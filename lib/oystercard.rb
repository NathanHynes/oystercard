class Oystercard
  attr_reader :balance, :maximum
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @maximum = 90
  end

  def top_up(amount)
    raise "balance cannot exceed £#{maximum}" if over_maximum?(amount)

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def over_maximum?(amount)
    balance + amount > @maximum
  end
end
