require_relative 'spec_helper'
require 'midterm_project'

RSpec.describe Card do
  let(:card) { Card.new("Ten", "Spades") }

  describe "#display" do
    it "tells the user which card it is" do
      expect { card.display }.to output("Ten of Spades\n").to_stdout
    end
  end
end
