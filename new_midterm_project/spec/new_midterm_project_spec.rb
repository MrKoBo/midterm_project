# /new_midterm_project/spec
require 'new_midterm_project'


RSpec.describe Card do
  let(:card) { Card.new(1, "Spades") }

  describe "#display" do
    it "tells the user which card it is" do
      expect { card.display }.to output("Ace of Spades\n").to_stdout
    end
  end
end

RSpec.describe Deck do
  describe "#shuffle_deck" do
    it "shuffles the current deck" do
      new_deck = Deck.new
      shuffeled_deck = new_deck.shuffle_deck
      expect(shuffeled_deck).not_to be (new_deck)
    end
  end
  describe "#deal" do
    it "returns top card" do
      new_deck = Deck.new
      first_card = new_deck.active_deck[0]
      card_dealt = new_deck.deal
      expect(card_dealt).to eq(first_card)
    end

    it "top card is removed" do
      new_deck = Deck.new
      card_dealt = new_deck.deal
      expect(new_deck.active_deck.length).to eq(51)
    end
  end
  describe "#get_cards" do
    it "creates a new hand of 5 cards" do
      new_deck = Deck.new
      my_hand = new_deck.get_cards
      expect(my_hand.active_hand.length).to eq(5)
    end
  end
end

RSpec.describe Hand do
  describe "#strength" do
    it "evaluates a Royal Flush correctly" do
      cards = [
        Card.new(10, "Hearts"),
        Card.new(11, "Hearts"),
        Card.new(12, "Hearts"),
        Card.new(13, "Hearts"),
        Card.new(1, "Hearts")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Royal Flush")
    end
    it "evaluates a Straight Flush correctly" do
      cards = [
        Card.new(6, "Hearts"),
        Card.new(4, "Hearts"),
        Card.new(5, "Hearts"),
        Card.new(7, "Hearts"),
        Card.new(3, "Hearts")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Straight Flush")
    end
    it "evaluates a Four of a Kind correctly" do
      cards = [
        Card.new(2, "Hearts"),
        Card.new(2, "Diamonds"),
        Card.new(6, "Hearts"),
        Card.new(2, "Clubs"),
        Card.new(2, "Spades")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Four of a Kind")
    end
    it "evaluates a Full House correctly" do
      cards = [
        Card.new(2, "Hearts"),
        Card.new(2, "Diamonds"),
        Card.new(2, "Spades"),
        Card.new(12, "Clubs"),
        Card.new(12, "Hearts")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Full House")
    end
    it "evaluates a Flush correctly" do
      cards = [
        Card.new(4, "Hearts"),
        Card.new(3, "Hearts"),
        Card.new(9, "Hearts"),
        Card.new(2, "Hearts"),
        Card.new(10, "Hearts")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Flush")
    end
    it "evaluates a Straight correctly" do
      cards = [
        Card.new(11, "Clubs"),
        Card.new(12, "Hearts"),
        Card.new(13, "Spades"),
        Card.new(10, "Hearts"),
        Card.new(1, "Diamondss")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Straight")
    end
    it "evaluates a Three of a Kind correctly" do
      cards = [
        Card.new(2, "Hearts"),
        Card.new(7, "Diamonds"),
        Card.new(6, "Hearts"),
        Card.new(2, "Clubs"),
        Card.new(2, "Spades")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Three of a Kind")
    end
    it "evaluates a Two Pairs correctly" do
      cards = [
        Card.new(2, "Hearts"),
        Card.new(2, "Diamonds"),
        Card.new(6, "Hearts"),
        Card.new(6, "Clubs"),
        Card.new(13, "Spades")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Two Pairs")
    end
    it "evaluates a Pair correctly" do
      cards = [
        Card.new(2, "Hearts"),
        Card.new(2, "Diamonds"),
        Card.new(6, "Hearts"),
        Card.new(10, "Clubs"),
        Card.new(11, "Spades")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Pair")
    end
    it "evaluates a High Card correctly" do
      cards = [
        Card.new(2, "Hearts"),
        Card.new(9, "Diamonds"),
        Card.new(6, "Hearts"),
        Card.new(10, "Clubs"),
        Card.new(4, "Spades")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("High Card")
    end
  end
  describe "#quality" do
    it "determines an outright winner" do
      cards1 = [
        Card.new(2, "Hearts"),
        Card.new(9, "Diamonds"),
        Card.new(6, "Hearts"),
        Card.new(10, "Clubs"),
        Card.new(4, "Spades")
      ]
      hand1 = Hand.new(cards1)
      cards2 = [
        Card.new(10, "Hearts"),
        Card.new(11, "Hearts"),
        Card.new(12, "Hearts"),
        Card.new(13, "Hearts"),
        Card.new(1, "Hearts")
      ]
      hand2 = Hand.new(cards2)
      expect(hand1.quality([hand1, hand2])).to eq(hand2)
    end

    it "determines winner when tied in game type kinds/pairs" do
      cards1 = [
        Card.new(2, "Hearts"),
        Card.new(4, "Diamonds"),
        Card.new(6, "Hearts"),
        Card.new(1, "Clubs"),
        Card.new(2, "Spades")
      ]
      hand1 = Hand.new(cards1)
      cards2 = [
        Card.new(5, "Hearts"),
        Card.new(2, "Diamonds"),
        Card.new(10, "Hearts"),
        Card.new(6, "Clubs"),
        Card.new(10, "Spades")
      ]
      hand2 = Hand.new(cards2)
      cards3 = [
        Card.new(1, "Hearts"),
        Card.new(2, "Diamonds"),
        Card.new(3, "Hearts"),
        Card.new(10, "Clubs"),
        Card.new(1, "Spades")
      ]
      hand3 = Hand.new(cards3)
      expect(hand1.quality([hand1, hand2, hand3])).to eq(hand3)
    end
    it "determines winner when tied in game type straight" do
      cards1 = [
        Card.new(2, "Hearts"),
        Card.new(1, "Diamonds"),
        Card.new(3, "Hearts"),
        Card.new(4, "Clubs"),
        Card.new(5, "Spades")
      ]
      hand1 = Hand.new(cards1)
      cards2 = [
        Card.new(1, "Hearts"),
        Card.new(13, "Diamonds"),
        Card.new(12, "Hearts"),
        Card.new(11, "Clubs"),
        Card.new(10, "Spades")
      ]
      hand2 = Hand.new(cards2)
      cards3 = [
        Card.new(7, "Hearts"),
        Card.new(8, "Diamonds"),
        Card.new(9, "Hearts"),
        Card.new(10, "Clubs"),
        Card.new(11, "Spades")
      ]
      hand3 = Hand.new(cards3)
      expect(hand1.quality([hand1, hand2, hand3])).to eq(hand2)
    end
    it "determines winner when tied in game type full house" do
      cards1 = [
        Card.new(12, "Hearts"),
        Card.new(10, "Diamonds"),
        Card.new(10, "Hearts"),
        Card.new(12, "Clubs"),
        Card.new(12, "Spades")
      ]
      hand1 = Hand.new(cards1)
      cards2 = [
        Card.new(1, "Hearts"),
        Card.new(1, "Diamonds"),
        Card.new(3, "Hearts"),
        Card.new(1, "Clubs"),
        Card.new(3, "Spades")
      ]
      hand2 = Hand.new(cards2)
      cards3 = [
        Card.new(2, "Hearts"),
        Card.new(4, "Diamonds"),
        Card.new(4, "Hearts"),
        Card.new(2, "Clubs"),
        Card.new(2, "Spades")
      ]
      hand3 = Hand.new(cards3)
      expect(hand2.quality([hand1, hand2, hand3])).to eq(hand2)
    end
    it "determines winner when tied in game type flush with aces" do
      cards1 = [
        Card.new(4, "Hearts"),
        Card.new(3, "Hearts"),
        Card.new(9, "Hearts"),
        Card.new(2, "Hearts"),
        Card.new(10, "Hearts")
      ]
      hand1 = Hand.new(cards1)
      cards2 = [
        Card.new(4, "Diamonds"),
        Card.new(9, "Diamonds"),
        Card.new(1, "Diamonds"),
        Card.new(11, "Diamonds"),
        Card.new(12, "Diamonds")
      ]
      hand2 = Hand.new(cards2)
      cards3 = [
        Card.new(7, "Spades"),
        Card.new(12, "Spades"),
        Card.new(9, "Spades"),
        Card.new(1, "Spades"),
        Card.new(11, "Spades")
      ]
      hand3 = Hand.new(cards3)
      expect(hand1.quality([hand1, hand2, hand3])).to eq(hand3)
    end
    it "determines winner when tied in game type flush with no aces" do
      cards1 = [
        Card.new(4, "Hearts"),
        Card.new(3, "Hearts"),
        Card.new(9, "Hearts"),
        Card.new(2, "Hearts"),
        Card.new(10, "Hearts")
      ]
      hand1 = Hand.new(cards1)
      cards2 = [
        Card.new(4, "Diamonds"),
        Card.new(9, "Diamonds"),
        Card.new(13, "Diamonds"),
        Card.new(11, "Diamonds"),
        Card.new(12, "Diamonds")
      ]
      hand2 = Hand.new(cards2)
      cards3 = [
        Card.new(2, "Spades"),
        Card.new(12, "Spades"),
        Card.new(9, "Spades"),
        Card.new(13, "Spades"),
        Card.new(11, "Spades")
      ]
      hand3 = Hand.new(cards3)
      expect(hand1.quality([hand1, hand2, hand3])).to eq(hand2)
    end
    it "determines winner when tied in game type High Card" do
      cards1 = [
        Card.new(1, "Hearts"),
        Card.new(4, "Diamonds"),
        Card.new(12, "Hearts"),
        Card.new(11, "Clubs"),
        Card.new(10, "Spades")
      ]
      hand1 = Hand.new(cards1)
      cards2 = [
        Card.new(2, "Hearts"),
        Card.new(9, "Diamonds"),
        Card.new(3, "Hearts"),
        Card.new(4, "Clubs"),
        Card.new(5, "Spades")
      ]
      hand2 = Hand.new(cards2)
      cards3 = [
        Card.new(7, "Hearts"),
        Card.new(8, "Diamonds"),
        Card.new(9, "Hearts"),
        Card.new(10, "Clubs"),
        Card.new(2, "Spades")
      ]
      hand3 = Hand.new(cards3)
      expect(hand1.quality([hand1, hand2, hand3])).to eq(hand1)
    end
  end
end
RSpec.describe Player do
  describe "#Discard" do
    it "allows users to keep cards" do
      cards = [
        Card.new(11, "Clubs"),
        Card.new(12, "Hearts"),
        Card.new(13, "Spades"),
        Card.new(10, "Hearts"),
        Card.new(1, "Diamonds")
      ]
      hand = Hand.new(cards)
      player = Player.new(hand, 50)
      new_hand = player.discard()
      expect(new_hand).to eq(player.my_hand)
    end
    it "allows users to discard valid amount of cards" do
      cards = [
        Card.new(11, "Clubs"),
        Card.new(12, "Hearts"),
        Card.new(13, "Spades"),
        Card.new(10, "Hearts"),
        Card.new(1, "Diamonds")
      ]
      hand = Hand.new(cards)
      player = Player.new(hand, 50)
      #simulates player entering 2 and 4
      allow(player).to receive(:gets).and_return("2 4\n")
      player.discard
      expect(player.my_hand.active_hand.length).to eq(3)
    end
  end
  describe "#Bet" do
    cards = [
      Card.new(11, "Clubs"),
      Card.new(12, "Hearts"),
      Card.new(13, "Spades"),
      Card.new(10, "Hearts"),
      Card.new(1, "Diamonds")
    ]
    hand = Hand.new(cards)
    player = Player.new(hand, 50)

    it "Tells the game I am going to Fold" do
      allow(player).to receive(:gets).and_return("Fold\n")
      bet = player.bet
      expect(bet).to eq("Fold")
    end

    it "Tells the game I am going to Raise" do
      allow(player).to receive(:gets).and_return("Raise\n")
      bet = player.bet
      expect(bet).to eq("Raise")
    end

    it "Tells the game I am going to See" do
      allow(player).to receive(:gets).and_return("See\n")
      bet = player.bet
      expect(bet).to eq("See")
    end
  end

end
RSpec.describe Game do
  describe "#Initalize" do
    game = Game.new(num_of_players = 4)
    it "Makes the correct amount of players" do
      list_of_players = game.players
      expect(list_of_players.length).to eq(4)
    end
    it "Gives all players 5 cards" do

      player1 = game.players["player1"]
      player2 = game.players["player2"]
      player3 = game.players["player3"]
      player4 = game.players["player4"]
      expect(player1.my_hand.active_hand.length).to eq(5)
      expect(player1.my_hand.active_hand.length).to eq(5)
      expect(player1.my_hand.active_hand.length).to eq(5)
      expect(player1.my_hand.active_hand.length).to eq(5)

    end

    it "Takes appropriate amount of cards away from deck" do
      expect(game.deck.active_deck.length).to eq(32)
    end
  end
  describe "#current_player_turn" do
    it "returns the correct player's turn" do
      game = Game.new()
      expect(game.current_player_turn).to eq("player1")
    end
  end

  describe "#next_turn" do
    it "updates the current player's turn to the next player" do
      game = Game.new()
      game.next_turn
      expect(game.current_player_turn).to eq("player2")
    end
  end
  describe "#ask_bet" do
    it "allows a player to place a bet and updates the pot" do
      game = Game.new(num_of_players = 4)
      initial_pot = game.pot
      game.raise_bet("player1", game.players["player1"])
      expect(game.pot).to be > initial_pot
    end

    it "updates the player's pot after placing a bet" do
      game = Game.new(num_of_players = 4)
      initial_pot = game.players["player1"].my_pot
      game.raise_bet("player1", game.players["player1"])
      expect(game.players["player1"].my_pot).to be < initial_pot
    end
    it "removes player from game if fold" do
      game = Game.new(num_of_players = 4)
      player_to_fold = "player1"
      game.fold(player_to_fold)
      expect(game.players.length).to eq(3)
    end
  end
end
