# frozen_string_literal: true
require_relative 'random_station'

# creates tube station
class Station
  attr_reader :name, :zone

  include RandomStation

  def initialize
    select_station
    @name = station_name
    @zone = station_zone
  end
end
