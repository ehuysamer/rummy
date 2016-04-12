require 'rails_helper'

RSpec.describe Card, type: :class do
  let(:card1) { Card.new(suite: 'D', rank: '5', value: 'D5') }
  let(:card2) { Card.new(suite: 'D', rank: '5', value: 'D5') }
  let(:card3) { Card.new(suite: 'H', rank: '1', value: 'H1') }

  describe 'rank_to_name' do
    it 'returns correct ranks for names' do
      expect(Card::RANKS.map{ |name| Card.name_to_rank(name) }).to eq (1..13).to_a
    end
  end

  describe 'name_to_rank' do
    it 'returns correct names for ranks' do
      expect((1..13).to_a.map{ |name| Card.rank_to_name(name) }).to eq Card::RANKS
    end
  end

  describe 'Get rank from value' do
    it 'Returns the correct ranks for symbolic names' do
      expect(%w(H10 HJ HQ HK HA).map{ |name| Card.rank_of_value(name) }).to eq [10, 11, 12, 13, 1]
    end

    it 'Returns the correct ranks for symbolic names with joker' do
      expect(%w(JH10 JHJ JHQ JHK JHA).map{ |name| Card.rank_of_value(name) }).to eq [10, 11, 12, 13, 1]
    end
  end

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
