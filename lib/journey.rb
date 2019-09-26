require_relative 'oystercard'
require_relative 'station'
require_relative 'journeylog'

class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :route, :penalty, :exit_zone, :entry_zone, :journeylog

  def initialize
    @route = { entry: nil, exit: nil}
    @penalty = PENALTY_FARE
    @journeylog = JourneyLog.new
  end

  def start(entry_station)
    # zone_on_entry(entry_station)
    journeylog.start(entry_station)
  end

  def finish(exit_station)
    # zone_on_exit(exit_station)
    journeylog.finish(exit_station)
  end

  def complete?
    !@journeylog.route.has_value?(nil)
  end

  def fare
    return PENALTY_FARE unless complete?
    MINIMUM_FARE
  end

  # private

  # def zone_on_entry(entry_station)
  #   @entry_zone = entry_station.zone
  # end

  # def zone_on_exit(exit_station)
  #   @exit_zone = exit_station.zone
  # end
end
