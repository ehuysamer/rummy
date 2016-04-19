require 'rails_helper'

RSpec.describe Discard, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { %w(joker joker2) }
  let(:joker1_card) { round.find_card(value: 'joker') }
  let(:joker1_value) { 'H4' }
  let(:joker1_suite) { Card.suite_of_value(joker1_value) }
  let(:joker1_rank) { Card.rank_of_value(joker1_value) }
  let(:joker2_card) { round.find_card(value: 'joker2') }
  let(:joker2_value) { 'D2' }
  let(:joker2_suite) { Card.suite_of_value(joker2_value) }
  let(:joker2_rank) { Card.rank_of_value(joker2_value) }

  let(:round) do
    round = Round.new(4)

    cards.each { |val| round.current_player.hand << round.steal_card(value: val) }

    round
  end

  let!(:result) { JokerImpersonate.new(round, round.current_player, joker1_value, joker2_value).call }

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
