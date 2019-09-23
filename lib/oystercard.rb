class Oystercard
  attr_reader :balance
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(money)
    @balance += money
  end
end
