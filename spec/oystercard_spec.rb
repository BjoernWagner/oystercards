require 'oystercard'

describe Oystercard do
  subject(:card) { Oystercard.new }

  describe '#top_up' do
    it 'responds to #top_up with 1 argument' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'adds the argument value to existing balance' do
      expect{card.top_up(10.00)}.to change{card.balance}.by(10.00)
    end

    it "raises an error when trying to add more than #{Oystercard::MAXIMUM_BALANCE}" do
      expect{card.top_up(100.00)}.to raise_error "Warning! Cannot add more than #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  describe '#balance' do
    it 'returns a balance' do
      expect(card.balance).to eq 0
    end
  end

  describe '#deduct' do
    it 'responds to #deduct with one argument' do
      expect(card).to respond_to(:deduct).with(1).argument
    end

    it 'subtracts the argument value from existing balance' do
      expect{card.deduct(10.00)}.to change{card.balance}.by(-10.00)
    end
  end

  describe '#in_journey' do
    it 'when creating a new card it is not in journey' do
      expect(card.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'is in journey when touched in' do
      card.touch_in
      expect(card).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'is not in journey when touched out' do
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end
  end


end
