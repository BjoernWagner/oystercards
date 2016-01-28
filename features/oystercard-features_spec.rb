require 'oystercard'

describe Oystercard do

  it "Records all the previous trips" do
    card = Oystercard.new
    card.top_up(2)
    entry_station = :station
    card.touch_in(entry_station)
    card.touch_out
    expect(card.previous_journeys).to include_entry_station
    # In order to know where I have been
    # As a customer
    # I want to see to all my previous trips
  end

end
