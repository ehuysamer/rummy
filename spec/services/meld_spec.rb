require 'rails_helper'

RSpec.describe Meld, type: :class do
  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { %w(joker joker2 D2 D3 D4 H4 S4) }
  let(:cards_to_meld) { %w(D4 H4 S4) }
  let(:meld_cards) { cards_to_meld.map{|card| round.find_card(value: card)} }
  let(:player) { round.current_player }
  let(:hand) { player.hand }
  let(:meld) { round.find_meld(meld_cards) }
  let(:joker1) { }
  let(:joker2) { }
  let(:joker1_card) { round.find_card(value: 'joker') }
  let(:joker2_card) { round.find_card(value: 'joker2') }
  let(:round) { Round.new(4) }
  let(:result) { Meld.new(round:round, player:player, cards: meld_cards).call }

  before do
    cards.each { |val| round.current_player.hand << round.steal_card(value: val) }

    if joker1 || joker2
      JokerImpersonate.new(round, player, joker1, joker2).call
    end

    result
  end

  context 'user melds rank' do
    it 'returns true' do
      expect(result).to be_truthy
    end

    it 'melds to correct stack' do
      expect(meld.rank).to eq 4
    end

    it 'adds cards to meld' do
      expect(meld.to_ids).to have_all cards_to_meld
    end

    it 'removes cards from hand' do
      expect(hand.to_ids).to have_none cards_to_meld
    end

    it 'assigns meld to player' do
      expect(meld.owner).to eq player
    end
  end

  context 'user melds suite; out of order' do
    let(:cards_to_meld) { %w(D4 D2 D3) }

    it 'returns true' do
      expect(result).to be_truthy
    end

    it 'melds to correct stack' do
      expect(meld.suite).to eq 'D'
    end

    it 'adds card to meld stack' do
      expect(meld.to_ids).to have_all cards_to_meld
    end

    it 'removes card from hand' do
      expect(hand.to_ids).to have_none cards_to_meld
    end

    it 'assigns meld to player' do
      expect(meld.owner).to eq player
    end
  end

  context 'user melds rank with jokers' do
    let(:cards_to_meld) { %w(D4 joker joker2) }
    let(:joker1) { 'H4' }
    let(:joker2) { 'C4' }

    it 'has set the joker impersonations' do
      expect(joker1_card.suite).to eq 'H'
      expect(joker1_card.rank).to eq 4
      expect(joker2_card.suite).to eq 'C'
      expect(joker2_card.rank).to eq 4
    end

    it 'returns true' do
      expect(result).to be_truthy
    end

    it 'melds to correct stack' do
      expect(meld.rank).to eq 4
    end

    it 'adds card to meld stack' do
      expect(meld.to_ids).to have_all cards_to_meld
    end

    it 'removes card from hand' do
      expect(hand.to_ids).to have_none cards_to_meld
    end

    it 'assigns meld to player' do
      expect(meld.owner).to eq player
    end
  end

  context 'user melds suite with jokers' do
    let(:cards_to_meld) { %w(D4 joker joker2) }
    let(:joker1) { 'D3' }
    let(:joker2) { 'D5' }

    it 'returns true' do
      expect(result).to be_truthy
    end

    it 'melds to correct stack' do
      expect(meld.suite).to eq 'D'
    end

    it 'adds card to meld stack' do
      expect(meld.to_ids).to have_all cards_to_meld
    end

    it 'removes card from hand' do
      expect(hand.to_ids).to have_none cards_to_meld
    end

    it 'assigns meld to player' do
      expect(meld.owner).to eq player
    end
  end

  context 'user melds rank already owned by other player' do
    let(:cards_to_meld) { %w(D4 H4 C4) }

    before do
      meld.owner = round.players[3]
    end

    it 'melds the cards' do
      expect(meld.to_ids).to have_all cards_to_meld
    end

    it 'doesnt assign meld to player' do
      expect(meld.owner).to eq round.players[3]
    end
  end
end
