#lib/midterm_project.rb

class Card
  attr_accessor :suit, :value

  def initialize(value, suit)
    @suit = suit
    @value = value
  end

  def display
    value_str = case value
      when [1,14] then "Ace"
      when 11 then "Jack"
      when 12 then "Queen"
      when 13 then "King"
      else value.to_s
      end
    puts "#{value_str} of #{suit}"
  end
end

class Deck
  attr_accessor :active_deck

  def initialize
    @suits = ["Diamonds", "Hearts", "Clubs", "Spades"]
    @values = [1,2,3,4,5,6,7,8,9,10,11,12,13]
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
  def give_cards
    new_hand = []
    5.times do |item|
      item = deal
      new_hand << item
    end
    Hand.new(new_hand)
  end
end
class Hand
  attr_accessor :active_hand
  def initialize(active_hand)
    @active_hand = active_hand

    @hierarchy = {
      "Straight Flush" => 9,
      "Four of a Kind" => 8,
      "Full House" => 7,
      "Flush" => 6,
      "Straight" => 5,
      "Three of a Kind" => 4,
      "Two Pairs" => 3,
      "Pair" => 2,
      "High Card" => 1
    }

  end

  def quality
    current_values = []
    @active_hand.each do |card|
      value = card.value
      current_values << value
    end
    @sorted_values = current_values.sort
  end
end
