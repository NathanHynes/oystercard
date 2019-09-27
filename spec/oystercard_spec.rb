# frozen_string_literal: true

require 'oystercard'
require 'journey'
require 'station'
require 'journeylog'

describe Oystercard do
  let(:oyster) { Oystercard.new }
  let(:station_a) { double :station, zone: 1 }
  let(:station_b) { double :station, zone: 1 }
  let(:journey) { double :journey, fare: 1 }

  it 'should have a default balance of 0' do
    expect(oyster.balance).to eq 0
  end

  describe '#show_balance' do
    it 'shows balance' do
      subject.top_up(10)
      expect(subject.show_balance).to eq "Card balance: #{subject.balance}"
    end
  end

  describe '#top_up' do
    it 'should allow user to add money to oystercard' do
      oyster.top_up(5)
      expect(oyster.balance).to eq 5
    end

    it 'should raise error if over limit' do
      oyster.top_up(Oystercard::MAXIMUM_BALANCE)
      expect { oyster.top_up(Oystercard::MINIMUM_BALANCE) }.to raise_error "balance cannot exceed £#{oyster.maximum}"
    end
  end

  describe '#touch_in' do
    before do
      oyster.top_up(Oystercard::MAXIMUM_BALANCE)
      oyster.touch_in(station_a)
    end

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it "should raise error if card doesn't have minimum fare" do
      expect { subject.touch_in(station_a) }.to raise_error 'Insufficient balance to touch in'
    end

    it 'should record entry station' do
      expect(oyster.entry_station).to eq station_a
    end

    it 'charges penalty if touch in twice' do
      oyster.touch_in(station_a)
      expect { oyster.touch_in(station_b)}.to change { oyster.balance}.by -6
    end
  end

  describe '#touch_out' do
    before do
      oyster.top_up(Oystercard::MAXIMUM_BALANCE)
      oyster.touch_in(station_a)
      allow(journey).to receive(:complete?).and_return true
    end

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'should charge the card by £1 if traveling across the same zone' do
      expect { oyster.touch_out(station_b) }.to change { oyster.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'changes entry station to nil' do
      expect { oyster.touch_out(station_b) }.to change { oyster.entry_station }.to eq nil
    end
  end
end
