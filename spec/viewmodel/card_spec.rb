require 'rails_helper'

RSpec.describe Card, type: :class do
  let(:card1) { Card.new(suite: 'D', rank: '5', value: 'D5') }
  let(:card2) { Card.new(suite: 'D', rank: '5', value: 'D5') }
  let(:card3) { Card.new(suite: 'H', rank: '1', value: 'H1') }

  describe 'Compare Value' do
    it 'returns true if cards have similar values' do
      expect(card1.compare_value_to(card2)).to be_truthy
    end

    it 'returns false if cards have different values' do
      expect(card1.compare_value_to(card3)).to be_falsey
    end
  end

  describe 'Compare Rank and Suite' do
    it 'returns true if cards have similar rank and suite' do
      expect(card1.compare_rank_suite_to(card2)).to be_truthy
    end

    it 'returns false if cards have different rank and suite' do
      expect(card1.compare_rank_suite_to(card3)).to be_falsey
    end
  end
end
