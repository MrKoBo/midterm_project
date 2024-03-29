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
  attr_accessor :active_hand, :current_values

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
    @hand_suits = []
    @active_hand.each do |card|
      @current_values << card.value
      @hand_suits << card.suit
    end
    @sorted_values = @current_values.sort
  end

  def strength
    return "Royal Flush" if royal_flush
    return "Straight Flush" if straight_flush
    return "Four of a Kind" if four_of_a_kind
    return "Full House" if full_house
    return "Flush" if flush
    return "Straight" if straight
    return "Three of a Kind" if three_of_a_kind
    return "Two Pairs" if two_pairs
    return "Pair" if pair
    "High Card"
  end


  def royal_flush
    first_suit = @hand_suits[0]
    @hand_suits.each do |suit|
      return false if suit != first_suit
    end
    return false if @sorted_values != [1, 10, 11, 12, 13]
    true
  end
  def straight_flush
    first_suit = @hand_suits[0]
    @hand_suits.each do |suit|
      return false if suit != first_suit
    end
    (0...4).each do |i|
      return false unless @sorted_values[i] + 1 == @sorted_values[i + 1]
    end
    return true

  end
  def four_of_a_kind
    counts = Hash.new(0)
    @sorted_values.each do |item|
      counts[item] += 1
    end
    counts.each do |key, value|
      return true if counts[key] == 4
    end
    false
  end
  def full_house
    counts = Hash.new(0)
    @sorted_values.each do |item|
      counts[item] += 1
    end
    counts.each do |key, value|
      return true if (counts[key] == 3 && counts.length == 2)
    end
    false
  end
  def flush
    first_suit = @hand_suits[0]
    @hand_suits.each do |suit|
      return false if suit != first_suit
    end
    true
  end
  def straight
    return true if @sorted_values == [1, 10, 11, 12, 13]
    (0...4).each do |i|
      return false unless @sorted_values[i] + 1 == @sorted_values[i + 1]
    end

    return true
  end
  def three_of_a_kind
    counts = Hash.new(0)
    @sorted_values.each do |item|
      counts[item] += 1
    end
    counts.each do |key, value|
      return true if counts[key] == 3
    end
    false
  end
  def two_pairs
    counts = Hash.new(0)
    @sorted_values.each do |item|
      counts[item] += 1
    end
    counts.each do |key, value|
      return true if (counts[key] == 2 && counts.length == 3)
    end
    false
  end
  def pair
    counts = Hash.new(0)
    @sorted_values.each do |item|
      counts[item] += 1
    end
    counts.each do |key, value|
      return true if counts[key] == 2
    end
    false
  end
  def quality(hands)
    best_hand = []
    best_hand_strength = 1
    hands.each do |hand|
      if @hierarchy[hand.strength] > best_hand_strength
        best_hand << hand
        best_hand_strength = @hierarchy[hand.strength]
      end
    end
    hands.each do |hand|
      if @hierarchy[hand.strength] == best_hand_strength
        best_hand << hand
      end
    end
    return best_hand[0] if best_hand.uniq.length == 1

    #tied at game type kinds/pairs
    best_tied_hand = nil
    best_tied_value = 0

    best_hand.each do |hand|
      max_value = hand.current_values.max
      return hand if hand.current_values.count(1) > 1


      if max_value > best_tied_value
        best_tied_hand = hand
        best_tied_value = max_value
      end
    end

  best_tied_hand
  end
end
