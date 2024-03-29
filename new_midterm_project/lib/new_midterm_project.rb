#lib/midterm_project.rb

class Card
  attr_accessor :suit, :value

  def initialize(value, suit)
    @suit = suit
    @value = value
  end

  def display
    value_str = case value
      when 1 then "Ace"
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
  attr_accessor :active_hand, :sorted_values

  def initialize(active_hand)
    @active_hand = active_hand
    @hierarchy = {
      "Royal Flush" => 10,
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
    @current_values = []
    @active_hand.each do |card|
      @current_values << card.value
    end
    @sorted_values = @current_values.sort
  end

  def strength
    return "Straight" if straight
    "High Card"
  end

  private

  def straight
    return false if @sorted_values.nil? || @sorted_values.empty?
    # Check for a regular straight (non-wrap-around)
    return true if @sorted_values == [1, 10, 11, 12, 13]
    (0...4).each do |i|
      return false unless @sorted_values[i] + 1 == @sorted_values[i + 1]
    end

    return true
  end

end
cards = [
        Card.new(10, "Hearts"),
        Card.new(11, "Hearts"),
        Card.new(12, "Hearts"),
        Card.new(13, "Hearts"),
        Card.new(1, "Hearts")
      ]
