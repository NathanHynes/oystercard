class Oystercard
  attr_reader :balance , :maximum
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @maximum = 90
  end

  def top_up(money)
    fail "balance cannot exceed £#{maximum}" if (@balance += money) > maximum
    balance
  end
end
