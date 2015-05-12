require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  describe '#initialize' do
    it 'has 52 cards' do
      expect(deck.cards.count).to eq(52)
    end
  end

  describe '#deal_card' do
    it 'returns a card' do
      expect(deck.deal_card).to be_a(Card)
    end

    it 'decreases the size of the deck by one' do
      orig_size = deck.cards.size
      deck.deal_card
      expect(deck.cards.size).to eq(orig_size - 1)
    end

    it 'removes the card that was dealt from the deck' do
      orig_card = deck.deal_card
      expect(deck.cards).to_not include(orig_card)
    end
  end

  # describe '#shuffle'
  #
  #
  #   end
  # end

end
