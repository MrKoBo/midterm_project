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
      my_hand = new_deck.give_cards
      expect(my_hand.active_hand.length).to eq(5)
    end
  end
end

RSpec.describe Hand do
  describe "#strength" do
    it "evaluates a Straight correctly" do
      cards = [
        Card.new(10, "Hearts"),
        Card.new(11, "Hearts"),
        Card.new(12, "Hearts"),
        Card.new(13, "Hearts"),
        Card.new(1, "Hearts")
      ]
      hand = Hand.new(cards)
      expect(hand.strength).to eq("Straight")
    end

  end
end
