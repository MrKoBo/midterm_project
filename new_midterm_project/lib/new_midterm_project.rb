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
    @values.each do |value|
      @suits.each do |suit|
        card = Card.new(value, suit)
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
  def get_cards
    new_hand = []
    5.times do |item|
      item = deal
      new_hand << item
    end
    return Hand.new(new_hand)
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

    # Find the highest-strength hands
    hands.each do |hand|
      strength = @hierarchy[hand.strength]
      if strength > best_hand_strength
        best_hand = [hand]
        best_hand_strength = strength
      elsif strength == best_hand_strength
        best_hand << hand
      end
    end

    # If there's only one highest-strength hand, return it
    return best_hand[0] if best_hand.length == 1

    # If there are tied hands, handle the tie
    return tied_kinds_or_pairs(best_hand) if (best_hand_strength == 2 || best_hand_strength == 3 || best_hand_strength == 4 || best_hand_strength == 8)
    return tied_straight(best_hand) if (best_hand_strength == 5 || best_hand_strength == 9)
    return tied_full_house(best_hand) if best_hand_strength == 7
    return tied_flush(best_hand) if best_hand_strength == 6
    return tied_flush(best_hand)
  end
  def tied_kinds_or_pairs(hands)
    best_tied_hand = nil
    best_tied_value = 0

    hands.each do |hand|
      max_value = hand.current_values.max
      return hand if hand.current_values.count(1) > 1

      if max_value > best_tied_value
        best_tied_hand = hand
        best_tied_value = max_value
      end
    end

    best_tied_hand
  end
  def tied_straight(hands)
    best_tied_hand = nil
    best_tied_value = 0
    hands.each do |hand|
      if hand.current_values.count(1) == 1
        return hand if hand.current_values.sort[1] == 10
      end
      max_value = hand.current_values.max
      if max_value > best_tied_value
        best_tied_hand = hand
        best_tied_value = max_value
      end
    end
  end
  def tied_full_house(hands)
    best_tied_trio = 0

    hands.each do |hand|
      return hand if hand.current_values.count(1) == 3
      max_value = hand.current_values.max
      counts = Hash.new(0)
      hand.current_values.each do |item|
        counts[item] += 1
      end
      counts.each do |key, value|
        if counts[key] == 3
          best_tied_trio = key if key > best_tied_trio
        end
      end
    end
    best_tied_trio
  end
  def tied_flush(hands)
    best_tied_hands = []
    hands.each do |hand|
      best_tied_hands << hand if hand.current_values.min == 1
    end
    return best_tied_hands[0] if best_tied_hands.length == 1
    return find_best_value(hands) if best_tied_hands == []
    if best_tied_hands[0].current_values.min == 1
      highest_tiebreaker = find_best_value(best_tied_hands)
      return highest_tiebreaker
    end


  end
  def find_best_value(hands)
    potential_match = hands
    4.downto(0) do |i|
      max_value = nil
      potential_match.each do |hand|
        if max_value.nil? || hand.current_values.sort[i] > max_value
          max_value = hand.current_values.sort[i]
        end
      end
      #modify potential list
      potential_match.select! { |hand| hand.current_values.sort[i] == max_value }
      return potential_match[0] if potential_match.length == 1
    end
  end
end
class Player
  attr_accessor :my_hand, :my_pot
  def initialize(my_hand, my_pot)
    @my_hand = my_hand
    @my_pot = my_pot
  end
  def discard
    #each index allow me to use the index of each my_hand and not the actual card
    @my_hand.active_hand.each_index do |i|
      puts "Card #{i + 1}: #{@my_hand.active_hand[i].display}"
    end
    puts "You currently have a #{@my_hand.strength}"
    puts "Which cards would you like to discard? If none type 0: "

    begin
      input = gets.chomp
      string_index = input.split(" ")
      deletable_indicies = string_index.map {|num| num.to_i - 1}
      raise ArgumentError, "Error: too many cards. (make sure you put a single space between them), Ex: 1 2 4,\nTry Again:" if deletable_indicies.length > 3
      raise ArgumentError, "Error: one of those cards does not exist. (Range is 1-5) \nTry again: " if (deletable_indicies.max > 4 || deletable_indicies.min < -1)
    rescue ArgumentError => e
      puts "#{e.message}"
      retry
    end
    return @my_hand if deletable_indicies[0] == -1
    kept_cards = []
    #each_with_index almost simulates a hash where i get element, index for each item
    @my_hand.active_hand.each_with_index do |card, index|
      #if index of my current card is not a deletable one, keep it
      kept_cards << card if !deletable_indicies.include?(index)
    end
    @my_hand.active_hand = kept_cards
    @my_hand
  end
  def bet
    puts "You currently have #{@my_pot} chips.\nWhich betting would you like to make (Fold, Raise, See): "
    input = gets.chomp
  end

end
class Game
  attr_accessor :pot, :deck, :players, :current_player_turn, :bet

  def initialize(num_of_players = 2, player_pot = 100, deck = Deck.new)
    @num_of_players = num_of_players
    @player_pot = player_pot
    @players = {}
    @deck = deck
    @deck.shuffle_deck
    #make the player with 5 cards
    (0...@num_of_players).each do |i|
      player_name = "player#{i + 1}"
      new_hand = @deck.get_cards
      @players[player_name] = Player.new(new_hand, @player_pot)
    end
    #make a dictonary to help keep up with turns
    @num_rep_of_player = {}
    @players.each do |key, _|
      player_number = key.slice(6..-1).to_i
      @num_rep_of_player[key] = player_number
    end
    #start the game with player1
    @current_player_turn = "player1"
    #in order to start betting you have to put in at least 15
    @bet = 15
    @pot = 0
  end

  def next_turn
    current_player_number = @num_rep_of_player[@current_player_turn]
    next_player_number = (current_player_number % @num_of_players) + 1
    @current_player_turn = "player#{next_player_number}"
    @current_player_turn = "player1" if next_player_number > @num_of_players
  end
  def ask_bet
    @players.each do |key, value|
      puts "Hello #{key}"
      bet_result = value.bet
      fold(key) if bet_result == "Fold"
      see(value) if bet_result == "See"
      raise_bet(key, value) if bet_result == "Raise"
    end
  end
  def fold(player_name)
    @players.delete(player_name)
    @players
  end
  def see(player_object)
    if player_object.my_pot > @bet
      player_object.my_pot -= @bet
      @pot += @bet
    end
  end
  def raise_bet(player_name, player_object)
    puts "What would you like to the bet to? (Plug in bet amount higher than #{@bet})"
    input = gets.chomp
    @bet = input.to_i
    if player_object.my_pot > @bet
      player_object.my_pot -= @bet
      @pot += @bet
    else
      puts "You tried to steal so now you fold"
      fold(player_name)
    end
  end
end
