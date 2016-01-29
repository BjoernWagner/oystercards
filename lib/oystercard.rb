class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :previous_journeys

  DEFAULT_BALANCE = 0.0
  MAXIMUM_BALANCE = 90.0
  MINIMUM_FARE = 1.0

  def initialize
    @balance = DEFAULT_BALANCE
    @previous_journeys = []
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
    @entry_station =  entry_station
    log_trip(@entry_station, @exit_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    log_trip(@entry_station, exit_station)
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

  def log_trip(entry, exit)
    # if we're in journey, we want to modify the previous hash
    # and not create a new one
    if in_journey? && exit != nil
      previous_journeys.last[entry] = exit
    else
      hash = {}
      hash[entry] = exit
      previous_journeys.push(hash)
    end
  end

end
