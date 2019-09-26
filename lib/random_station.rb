# frozen_string_literal: true

require 'csv'

class RandomStation
  def initialize(filename = 'stations.csv')
    @filename = filename
  end

  def select_station
    stations.sample
  end

  attr_reader :filename, :list

  def stations
    list = []
    CSV.foreach(filename) do |line|
      name, zone = line
      list << { name: name, zone: zone }
    end
    list
  end
end
