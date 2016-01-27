class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0.0
  MAXIMUM_BALANCE = 90.0
  MINIMUM_BALANCE = 1.0

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def top_up(amount)
    raise "Warning! Cannot add more than #{MAXIMUM_BALANCE}" if exceed_maximum?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Below minimum fare of #{MINIMUM_BALANCE}" if below_minimum?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceed_maximum?(amount)
    (@balance + amount) > 90
  end

  def below_minimum?
    @balance < MINIMUM_BALANCE
  end

end
