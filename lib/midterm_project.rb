#lib/midterm_project.rb

class Card
  attr_accessor :suit, :value
  def initialize(value, suit)
    @suit = suit
    @value = value
  end

  def display()
    puts "#{value} of #{suit}"
  end
end
class Deck
  attr_accessor :active_deck

  def initialize
    @suits = ["Diamonds", "Hearts", "Clubs", "Spades"]
    @values = {
      "Ace" => [1, 14],
      "Two" => 2,
      "Three" => 3,
      "Four" => 4,
      "Five" => 5,
      "Six" => 6,
      "Seven" => 7,
      "Eight" => 8,
      "Nine" => 9,
      "Ten" => 10,
      "Jack" => 11,
      "Queen" => 12,
      "King" => 13
    }
    @start_deck = []
    @values.each do |key, value|
      @suits.each do |item|
        card = Card.new(key, item)
        @start_deck << card
      end
    end
    @active_deck = @start_deck
  end

  def shuffle_deck
    @active_deck.shuffle!
  end

  def deal
    top_card = @active_deck.shift
  end
end

class Hnad
end
class Player
end
class Game
end
