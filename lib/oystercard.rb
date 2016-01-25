class OysterCard
  Limit = 90.00

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise "Warning! Cannot add more than #{Limit}" if new_balance(money) > Limit
    @balance = new_balance(money)
  end

  def deduct(money)
    @balance -= money
  end

  def new_balance(money)
    @balance + money
  end
end
