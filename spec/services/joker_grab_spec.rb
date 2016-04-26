require 'rails_helper'

RSpec.describe JokerGrab, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:round) { Round.new(4) }
  let(:player1) { round.players[3] }
  let(:player2) { round.current_player }
  let(:card_ids_to_meld) { %w(joker joker2 SA) }
  let(:cards_p1) { %w(H2 H3 H4 joker joker2 SA) }
  let(:cards_p2) { %w(HA DA) }
  let(:joker1_rank) { 1 }
  let(:joker1_suite) { 'H' }
  let(:joker2_rank) { 1 }
  let(:joker2_suite) { 'D' }
  let(:card_to_grab) { 'HA' }
  let(:meld) { round.find_meld(player1.hand.select(card_ids_to_meld)) }

  before do
    cards_p1.each { |card| player1.hand << round.steal_card(id: card) }
    cards_p2.each { |card| player2.hand << round.steal_card(id: card) }
    round.deal

    round.current_player = player1

    #byebug

    JokerImpersonate.new(round: round, player: player1, joker_id: 'joker', value: 'HA').call
    JokerImpersonate.new(round: round, player: player1, joker_id: 'joker2', value: 'DA').call
    Meld.new(round: round, player: player1, cards: player1.hand.select(card_ids_to_meld)).call

    #byebug
  end

  context 'sets up the test case' do
    it 'puts the cards in the meld' do
      expect(meld.cards.map{|card| card.id}).to eq card_ids_to_meld
    end

    describe 'impersonates the jokers correctly' do
      let(:joker1) { round.find_card(id: 'joker') }
      let(:joker2) { round.find_card(id: 'joker2') }

      it 'found the first joker' do
        expect(joker1).not_to be_nil
      end

      it 'turned the first joker into a heart' do
        expect(joker1.suite).to eq 'H'
      end

      it 'turned the first joker into an ace' do
        expect(joker1.rank).to eq 1
      end

      it 'found the second joker' do
        expect(joker1).not_to be_nil
      end

      it 'turned the second joker into a diamond' do
        expect(joker2.suite).to eq 'D'
      end

      it 'turned the second joker into an ace' do
        expect(joker1.rank).to eq 1
      end
    end

    it 'has none of the cards left in player\'s hand' do
      expect(player1.hand.cards.map{|card| card.id}).to have_none card_ids_to_meld
    end
  end

  context 'grabs the joker' do
    before do
      round.current_player = player2
      JokerGrab.new(round, player2, card_to_grab).call
    end

    context 'Other player has melded with jokers owned by current player' do
      it 'has added the swap card to the meld, removing joker1' do
        expect(meld.cards.map{|card| card.id}).to eq %w(joker2 SA HA)
      end

      it 'has added the joker to the players hand' do
        expect(player2.hand.cards.map{|card| card.id}).to have_all %w(joker)
      end

      it 'has removed the swap card from the players hand' do
        expect(player2.hand.cards.map{|card| card.id}).to have_none %w(HA)
      end
    end
  end
end
