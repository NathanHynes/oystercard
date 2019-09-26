# frozen_string_literal: true

require 'station'

describe Station do
  let(:station) { Station.new(name: 'Old Street', zone: 1) }


  it 'should know its name' do
    expect(station.name).to eq 'Old Street'
  end

  it 'should know its zone' do
    expect(station.zone).to eq 1
  end
end
