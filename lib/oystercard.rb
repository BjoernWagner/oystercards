class Oystercard

  attr_reader :balance, :entry_station

  DEFAULT_BALANCE = 0.0
  MAXIMUM_BALANCE = 90.0
  MINIMUM_FARE = 1.0

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def top_up(amount)
    raise "Warning! Cannot add more than #{MAXIMUM_BALANCE}" if exceed_maximum?(amount)
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    raise "Below minimum fare of #{MINIMUM_FARE}" if below_minimum?
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def exceed_maximum?(amount)
    (@balance + amount) > MAXIMUM_BALANCE
  end

  def below_minimum?
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end

end
