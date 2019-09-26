# frozen_string_literal: true
require_relative 'random_station'

class Station
  attr_reader :name, :zone

  # include RandomStation

  def initialize(info = RandomStation.new.select_station)
    @name = info[:name]
    @zone = info[:zone]
  end
end
