class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0.0
  MAXIMUM_BALANCE = 90.0

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    raise "Warning! Cannot add more than #{Oystercard::MAXIMUM_BALANCE}" if exceed_maximum?(amount)
    @balance += amount
  end

  def exceed_maximum?(amount)
    (@balance + amount) > 90
  end

  def deduct(amount)
    @balance -= amount
  end

end
