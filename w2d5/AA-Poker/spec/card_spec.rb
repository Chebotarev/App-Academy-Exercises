require 'card'

describe Card do
  subject(:card) {Card.new(:spades, :ace)}

  describe '#suit' do
    it 'returns a suit' do
      expect(card.suit).to eq(:spades)
    end
  end

  describe '#value' do
    it 'returns a value' do
      expect(card.value).to eq(:ace)
    end
  end

  describe '#==' do
    context 'cards are equal' do
      it 'return true' do
        expect(Card.new(:spades, :ace) == Card.new(:spades, :ace)).to be true
      end
    end

    context 'cards are not equal' do
      it 'returns false' do
        expect(Card.new(:hearts, :king) == Card.new(:spades, :ace)).to be false
      end
    end


  end
end
