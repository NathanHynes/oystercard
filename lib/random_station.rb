# frozen_string_literal: true

require 'csv'

module RandomStation
  attr_reader :random_station

  def select_station(filename = 'stations.csv')
    stations = []
    CSV.foreach(filename) do |line|
      station, zone = line
      stations << { station: station, zone: zone }
    end
    @random_station = stations.sample
  end

  def station_name
    random_station[:station].to_s
  end

  def station_zone
    random_station[:zone].to_i
  end
end
