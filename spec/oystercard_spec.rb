require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}

  describe '#top_up' do
    it 'responds to #top_up with 1 argument' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'adds the argument value to existing balance' do
      expect{card.top_up(10.00)}.to change{card.balance}.by(10.00)
    end

    it "raises an error when adding more than #{Oystercard::MAXIMUM_BALANCE}" do
      message = "Warning! Cannot add more than #{Oystercard::MAXIMUM_BALANCE}"
      expect{card.top_up(100.00)}.to raise_error message
    end
  end

  describe '#balance' do
    it 'returns a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#in_journey' do
    it 'when creating a new card it is not in journey' do
      expect(card.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'is in journey when touched in' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      expect(card).to be_in_journey
    end

    it 'raises an error while touch in when below min balance' do
      message = "Below minimum fare of #{Oystercard::MINIMUM_FARE}"
      expect{card.touch_in(entry_station)}.to raise_error message
    end

  end

  describe '#touch' do
    it 'is not in journey when touched out' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card).not_to be_in_journey
    end

    it 'deducts by minimum fare when touch out' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      expect{card.touch_out(exit_station)}.to change{card.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it 'removes the entry station when touching out' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.entry_station).to eq nil
    end

  end

  describe '#journey' do
    it 'holds journey information' do
      expect(card.previous_journeys).to eq []
    end

    it 'saves entry station on touch in' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      expect(card.entry_station).to eq entry_station
    end

    it 'logs exit station on touch out' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.previous_journeys).to include ({entry_station=>exit_station})
    end



  end

end
