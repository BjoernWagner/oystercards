require 'oystercard'

describe OysterCard do
  subject(:card) { OysterCard.new }

  describe '#top_up' do
    it 'responds to #top_up with 1 argument' do
      expect(card).to respond_to(:top_up).with(1).argument
    end

    it 'adds the argument value to existing balance' do
      expect{card.top_up(10.00)}.to change{card.balance}.by(10.00)
    end

    it "raises an error when trying to add more than #{OysterCard::Limit}" do
      expect{card.top_up(100.00)}.to raise_error "Warning! Cannot add more than #{OysterCard::Limit}"
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
end
