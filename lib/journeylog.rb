# frozen_string_literal: true

require_relative 'journey'


class JourneyLog
  attr_reader :route, :journeys

  def initialize(journey = Journey.new)
    @current_route = journey
    @route = { entry: nil, exit: nil }
    @journeys = []
  end

  def start(entry_station)
    @current_route.start(entry_station)
    @route[:entry] = entry_station
  end

  def finish(exit_station)
    @route[:exit] = exit_station
    save_journey
    @current_route.finish(exit_station)
  end

  def fare
    @current_route.fare
  end

  def save_journey
    @journeys.push(@route)
    # @route = { entry: nil, exit: nil }
  end

  def show_history
    log = []
    @journeys.each do |hash|
      log << "#{hash[:entry]} ---> #{hash[:exit]}"
    end
    log
  end
end
