# frozen_string_literal: true

require_relative 'station'
require_relative 'journey'

# creates oystercards
class Oystercard
  attr_reader :balance, :maximum, :journey_history, :entry_station, :exit_station, :journey
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @maximum = MAXIMUM_BALANCE
    @journey_history = []
    @journey = Journey.new
  end

  def show_balance
    "Card balance: #{@balance}"
  end

  def top_up(amount)
    raise "balance cannot exceed £#{maximum}" if over_maximum?(amount)

    @balance += amount
  end

  def touch_in(entry_station)
    raise 'Insufficient balance to touch in' unless minimum_balance?

    journey.start(entry_station)
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    journey.finish(exit_station)
    deduct(journey.fare)
    @exit_station = exit_station
    @entry_station = nil
  end

  def show_journey_history
    log = []
    journey_history.each do |array|
      array.each do |entry, exit|
        log << "#{entry} ---> #{exit}"
      end
    end
    log
  end

  private

  def over_maximum?(amount)
    balance + amount > @maximum
  end

  def minimum_balance?
    balance >= MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
