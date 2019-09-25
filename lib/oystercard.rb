# frozen_string_literal: true

# creates oystercards
class Oystercard
  attr_reader :balance, :maximum, :journey_history, :entry_station, :exit_station
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = DEFAULT_BALANCE
    @maximum = MAXIMUM_BALANCE
    @journey_history = []
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

    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_BALANCE)
    @exit_station = exit_station
    save_journey(entry_station, exit_station)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
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

  def save_journey(entry, exit)
    last_journey = {}
    last_journey[entry] = exit
    @journey_history << last_journey
  end
end
