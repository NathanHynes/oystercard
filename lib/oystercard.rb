class Oystercard
  attr_reader :balance, :maximum, :journey
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @maximum = 90
    @journey = false
  end

  def top_up(amount)
    raise "balance cannot exceed £#{maximum}" if over_maximum?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @journey = true
  end

  def touch_out
    !@journey
  end

  def in_journey?
    @journey
  end

  private

  def over_maximum?(amount)
    balance + amount > @maximum
  end
end
