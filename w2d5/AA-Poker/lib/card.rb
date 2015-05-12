SUITS = [
  :spade,
  :heart,
  :diamond,
  :club
]

VALUES = [
  :two,
  :three,
  :four,
  :five,
  :six,
  :seven,
  :eight,
  :nine,
  :ten,
  :jack,
  :queen,
  :king,
  :ace
]

SYMBOLS_TO_VALUES = {
  :two => 2,
  :three => 3,
  :four => 4,
  :five => 5,
  :six => 6,
  :seven => 7,
  :eight => 8,
  :nine => 9,
  :ten => 10,
  :jack => 11,
  :queen => 12,
  :king => 13,
  :ace => 14
}

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end


  def ==(card)
    self.suit == card.suit && self.value == card.value
  end

end
