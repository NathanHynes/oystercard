require_relative 'oystercard'

class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def start(entry_station)
    @entry_station = entry_station
  end

  def finish(exit_station)
    @exit_station = exit_station
  end

  def complete?
    !!@entry_station && !!@exit_station
  end

  def fare
    return PENALTY_FARE unless complete?

    (entry_station.zone.to_i - exit_station.zone.to_i).abs + MINIMUM_FARE
  end
end
