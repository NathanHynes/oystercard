# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:oyster) { Oystercard.new }
  let(:station_a) { double :station }
  let(:station_b) { double :station }

  it 'should have a default balance of 0' do
    expect(oyster.balance).to eq 0
  end

  it 'initialises a new card with no journey history' do
    expect(subject.journey_history).to be_empty
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

    it 'should initially not be in a journey' do
      expect(subject).not_to be_in_journey
    end

    it 'should change journey status to true' do
      expect(oyster).to be_in_journey
    end

    it "should raise error if card doesn't have minimum fare" do
      expect { subject.touch_in(station_a) }.to raise_error 'Insufficient balance to touch in'
    end

    it 'should record entry station' do
      expect(oyster.entry_station).to eq station_a
    end
  end

  describe '#touch_out' do
    before do
      oyster.top_up(Oystercard::MAXIMUM_BALANCE)
      oyster.touch_in(station_a)
    end

    it { is_expected.to respond_to(:touch_out).with(1).argument }

    it 'should initial be in a journey' do
      expect(oyster).to be_in_journey
    end

    it 'should change journey status to false' do
      oyster.touch_out(station_b)
      expect(oyster).not_to be_in_journey
    end

    it 'should charge the minimum amount' do
      expect { oyster.touch_out(station_b) }.to change { oyster.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'changes entry station to nil' do
      expect { oyster.touch_out(station_b) }.to change { oyster.entry_station }.to eq nil
    end

    it 'should record exit station' do
      oyster.touch_out(station_b)
      expect(oyster.exit_station).to eq station_b
    end

    it 'saves journey' do
      oyster.touch_out(station_b)
      expect(oyster.journey_history).to eq [{ station_a => station_b }]
    end
  end
  describe '#show_journey_history' do
    before do
      oyster.top_up(Oystercard::MINIMUM_BALANCE)
      oyster.touch_in(station_a)
      oyster.touch_out(station_b)
    end
    it 'shows journey history' do
      expect(oyster.show_journey_history).to eq ["#{station_a} ---> #{station_b}"]
    end
  end
end
