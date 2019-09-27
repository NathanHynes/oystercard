# frozen_string_literal: true

require 'journey'
require 'station'
describe Journey do
  let(:card) { double :oystercard }
  let(:station_a) { double :station, zone: 1 }
  let(:station_b) { double :station, zone: 1 }
  let(:station_c) { double :station, zone: 3 }

  describe '#start' do
    it { is_expected.to respond_to(:start).with(1).argument }

    it 'stores entry station' do
      subject.start(station_a)
      expect(subject.entry_station).to eq station_a
    end
  end

  describe '#finish' do
    it { is_expected.to respond_to(:finish).with(1).argument }

    it 'stores exit station' do
      subject.finish(station_b)
      expect(subject.exit_station).to eq station_b
    end
  end

  describe '#complete' do
    it 'returns true if the journey is complete' do
      subject.start(station_a)
      subject.finish(station_b)
      expect(subject).to be_complete
    end

    it 'returns false if the journey is incomplete' do
      subject.start(station_a)
      expect(subject).not_to be_complete
    end
  end

  describe '#fare' do
    it 'charges minimum fare if journey is across one zone' do
      subject.start(station_a)
      subject.finish(station_b)
      expect(subject.fare).to be(Journey::MINIMUM_FARE)
    end

    it 'calculates fare travelling within different journey' do
      subject.start(station_a)
      subject.finish(station_c)
      expect(subject.fare).to be 3
    end

    it 'charges penalty fare if journey is incomplete' do
      subject.start(station_a)
      expect(subject.fare).to be(Journey::PENALTY_FARE)
    end
  end
end
