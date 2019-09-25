# creates oystercards
class Oystercard
  attr_reader :balance, :maximum, :journey
  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @maximum = MAXIMUM_BALANCE
    @journey = false
  end

  def top_up(amount)
    raise "balance cannot exceed £#{maximum}" if over_maximum?(amount)

    @balance += amount
  end

  def touch_in
    raise 'Insufficient balance to touch in' unless minimum_balance?

    @journey = true
  end

  def touch_out
    deduct(MINIMUM_BALANCE)
    !@journey
  end

  def in_journey?
    @journey
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
