#lib/midterm_project.rb

class Card
  possible_suits = ["Diamonds", "Hearts", "Clubs", "Spades"]
  possible_values = {
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
end
class Hnad
end
class Player
end
class Game
end
