require 'spec_helper'
require 'midterm_project'

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
      my_hand = new_deck.give_cards
      expect(my_hand.active_hand.length).to eq(5)
    end
  end
end

RSpec.describe Hand do
  let(:cards) do
    [
      Card.new(3, "Hearts"),
      Card.new(2, "Clubs"),
      Card.new(6, "Spades"),
      Card.new(5, "Diamonds"),
      Card.new(4, "Hearts")
    ]
  end
  let(:hand) { Hand.new(cards) }
  describe "#quality" do
    it "orders the cards in ascending order based on value" do
      expected_order = [2, 3, 4, 5, 6]
      sorted_values = hand.quality
      expect(sorted_values).to eq(expected_order)
    end
  end
  describe "#strength" do
    it "checks to see if there is a straight" do
      expect(hand.strength).to  eq(true)
    end
  end
end
