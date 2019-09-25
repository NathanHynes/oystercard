# frozen_string_literal: true
require 'csv'

class RandomStation
  attr_reader :stations, :random_station

  def initialize
    @stations = []
  end

  def random(filename = 'stations.csv')
    CSV.foreach(filename) do |line|
      station, zone = line
      @stations << { station: station, zone: zone }
    end
    @random_station = stations.sample
  end

  def read
    CSV.read('stations.csv')
  end
end
