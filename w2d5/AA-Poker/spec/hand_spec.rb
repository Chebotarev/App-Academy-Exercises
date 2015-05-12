require 'hand'

describe Hand do
  subject(:hand) {Hand.new}
  let(:card) { double("card", value: :ace, suit: :spade) }

  describe '#initialize' do
    it 'be empty' do
      expect(hand.cards.count).to eq(0)
    end
  end

  describe '#high_card' do
    it 'returns the card of highest value' do
      hand.cards = [
        card,
        double("card2", value: :ace),
        double("card3", value: :five),
        double("card4", value: :seven),
        double("card5", value: :two)
      ]
      expect(hand.high_card.value).to eq(:ace)
    end
  end

  describe '#one_pair'do
    it 'finds a pair of cards' do
      hand.cards = [
        card,
        double("card2", value: :ace),
        double("card3", value: :five),
        double("card4", value: :ace),
        double("card5", value: :two)
      ]

      expect(hand.one_pair).to eq(:ace)
    end

  end

  describe 'two_pairs'do
    it 'finds two pairs' do
      hand.cards = [
        card,
        double("card2", value: :ace),
        double("card3", value: :king),
        double("card4", value: :king),
        double("card5", value: :two)
      ]

      expect(hand.two_pairs).to eq([:ace, :king])
    end
  end


  describe '#three_of_a_kind'do
    it 'finds three of a kind' do
      hand.cards = [
        card,
        double("card2", value: :ace),
        double("card3", value: :ace),
        double("card4", value: :ace),
        double("card5", value: :two)
      ]

      expect(hand.three_of_a_kind).to eq(:ace)
    end
  end


  describe '#straight'do
    it 'finds a straight' do
      hand.cards = [
        double("card1", value: :king),
        double("card2", value: :queen),
        double("card3", value: :jack),
        double("card4", value: :ten),
        double("card5", value: :nine)
      ]

      expect(hand.straight).to eq(:king)
    end
  end


  describe '#flush'do
    it 'finds a flush' do
      hand.cards = [
        card,
        double("card2", suit: :spade, value: :king),
        double("card3", suit: :spade, value: :queen),
        double("card4", suit: :spade, value: :jack),
        double("card5", suit: :spade, value: :ten)
      ]

      expect(hand.flush).to eq([:ace, :king, :queen, :jack, :ten])
    end
  end

  describe '#full_house'do
    it 'finds a full house' do
      hand.cards = [
        card,
        double("card2", value: :ace),
        double("card3", value: :ace),
        double("card4", value: :king),
        double("card5", value: :king)
      ]

      expect(hand.full_house).to eq(:ace)
    end
  end


  describe '#four_of_a_kind'do
    it 'finds a four of a kind' do
      hand.cards = [
        card,
        double("card2", value: :ace),
        double("card3", value: :ace),
        double("card4", value: :ace),
        double("card5", value: :two)
      ]

      expect(hand.four_of_a_kind).to eq(:ace)
    end
  end

  describe '#straight_flush'do
    it 'finds straight_flush' do
      hand.cards = [
        card,
        double("card2", suit: :spade, value: :king),
        double("card3", suit: :spade, value: :queen),
        double("card4", suit: :spade, value: :jack),
        double("card5", suit: :spade, value: :ten)
      ]

      expect(hand.straight_flush).to eq(:ace)
    end
  end

  describe '#royal_flush'do
    it 'finds a royal flush' do
      hand.cards = [
        card,
        double("card2", suit: spade, value: :king),
        double("card3", suit: spade, value: :queen),
        double("card4", suit: spade, value: :jack),
        double("card5", suit: spade, value: :ten)
      ]

      expect(hand.royal_flush).to eq(:ace)
    end
  end

  describe '#discard' do
    it 'removes a target card from itself' do
      hand.cards << card
      orig_size = hand.cards.size
      hand.discard(card)
      expect(hand.cards.size).to eq(orig_size - 1)
    end

    it 'raises an error if the hand is empty' do
      expect { hand.discard(card) }.to raise_error(EmptyHandError)
    end
  end

  describe '#add_card' do
    it 'add the correct card' do
      hand.add_card(card)
      expect(hand.cards.last.suit).to eq(card.suit)
      expect(hand.cards.last.value).to eq(card.value)
    end

  end

end
