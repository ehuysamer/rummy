require 'rails_helper'

RSpec.describe Discard, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { %w(joker joker2) }
  let(:joker1_card) { round.find_card(id: 'joker') }
  let(:joker1_id) { 'H4' }
  let(:joker1_suite) { Card.suite_by_id(joker1_id) }
  let(:joker1_rank) { Card.rank_by_id(joker1_id) }
  let(:joker2_card) { round.find_card(id: 'joker2') }
  let(:joker2_id) { 'D2' }
  let(:joker2_suite) { Card.suite_by_id(joker2_id) }
  let(:joker2_rank) { Card.rank_by_id(joker2_id) }

  let(:round) do
    round = Round.new(4)

    cards.each { |val| round.current_player.hand << round.steal_card(id: val) }

    round
  end

  let!(:result) {
      JokerImpersonate.new(round: round, player: round.current_player, joker_id: 'joker', value: joker1_id).call &&
        JokerImpersonate.new(round: round, player: round.current_player, joker_id: 'joker2', value: joker2_id).call
  }

  context 'user sets value of jokers' do
    it 'Returns true' do
      expect(result).to be_truthy
    end

    it 'Set the correct rank for joker1' do
      expect(joker1_card.rank).to eq 4
    end

    it 'Set the correct rank for joker2' do
      expect(joker2_card.rank).to eq 2
    end

    it 'Set the correct suite for joker1' do
      expect(joker1_card.suite).to eq 'H'
    end

    it 'Set the correct suite for joker2' do
      expect(joker2_card.suite).to eq 'D'
    end
  end
end
