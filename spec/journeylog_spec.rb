# frozen_string_literal: true

require 'journeylog'
describe JourneyLog do
  let(:station_a) { double :station }
  let(:station_b) { double :station }

  describe '#start' do
    it { is_expected.to respond_to(:start).with(1).argument }

    it 'stores entry station' do
      subject.start(station_a)
      expect(subject.route[:entry]).to eq station_a
    end
  end

  describe '#finish' do
    it { is_expected.to respond_to(:finish).with(1).argument }

    it 'stores exit station' do
      subject.finish(station_b)
      expect(subject.route[:exit]).to eq station_b
    end
  end

  describe '#show_history' do
    it 'shows journey history' do
      subject.start(station_a)
      subject.finish(station_b)
      subject.save_journey
      expect(subject.show_history).to eq ["#{station_a} ---> #{station_b}"]
    end
  end

  describe '#save_journey' do
    it 'saves the last journey' do
      subject.start(station_a)
      subject.finish(station_b)
      expect(subject.save_journey).to eq [{ entry: station_a, exit: station_b }]
    end
  end
end
