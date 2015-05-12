require 'byebug'
require_relative 'deck'

class EmptyHandError < StandardError
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def discard(target_card)
    raise EmptyHandError if @cards.empty?
    @cards.each_with_index do |card, i|
      @cards.delete_at(i) if target_card == card
    end
  end


  def high_card
    # debugger
    return nil if @cards.empty?
    sorted_cards = @cards.sort_by do |card|
      SYMBOLS_TO_VALUES[card.value]
    end

    sorted_cards.last
  end

  private

  def find_card(suit, value)
    found_card = nil

    @cards.each do |card|
      if card.suit == suit && card.value == value
        found_card = card
      end
    end

    found_card
  end

end
