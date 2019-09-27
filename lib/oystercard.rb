# frozen_string_literal: true

require_relative 'station'
require_relative 'journeylog'

# creates oystercards
class Oystercard
  attr_reader :balance, :maximum, :journeylog, :entry_station, :exit_station, :journey
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(journeylog = JourneyLog.new)
    @balance = DEFAULT_BALANCE
    @maximum = MAXIMUM_BALANCE
    @journeylog = journeylog
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

    # refactor to maybe call journeylog save method
    deduct(journeylog.fare) unless journeylog.route[:entry].nil?
    journeylog.start(entry_station)
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    journeylog.finish(exit_station)
    deduct(journeylog.fare)
    @entry_station = nil
    @exit_station = exit_station
  end

  def show_journey_history
    journeylog.show_history.dup
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
