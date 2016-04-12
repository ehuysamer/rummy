require 'rails_helper'

RSpec.describe CardStack, type: :class do
  #include ApplicationHelper

  include CardStackHelpers
  include_context 'stack_samples'

  let(:cards) { [] }
  let(:stack) { CardStack.new(cards: cards) }

  describe 'Initialize' do
    it 'empty' do
      expect(CardStack.new.cards.length).to eq 0
    end
  end

  describe 'Add all' do
    let(:cards) { [] }

    before { stack.add_all }

    it 'to have everything' do
      expect(stack.cards.length).to eq 54
    end
  end

  describe 'Push' do
    let(:cards) { cards_2 }

    it 'has two cards' do
      expect(stack.cards.length).to eq 2
    end

    it 'has cards in correct order' do
      expect(stack.cards.map{ |card| card.value }).to eq %w(H2 C3)
    end
  end

  describe 'Pop' do
    let(:cards) { cards_2 }

    it 'pops the last card first' do
      expect(stack.pop.value).to eq 'C3'
    end

    it 'pops the first card next' do
      stack.pop
      expect(stack.pop.value).to eq 'H2'
    end
  end

  describe 'Shuffle' do
    let(:cards) { cards_5_with_joker }

    before do
      stack.shuffle
    end

    it 'still has 5 cards' do
      expect(stack.cards.length).to eq 5
    end

    it 'still has each card cards' do
      expect(stack.cards.map{ |card| card.value }).to include 'H2'
      expect(stack.cards.map{ |card| card.value }).to include 'C3'
      expect(stack.cards.map{ |card| card.value }).to include 'S4'
      expect(stack.cards.map{ |card| card.value }).to include 'D5'
      expect(stack.cards.map{ |card| card.value }).to include 'JOKER'
    end

    it 'has a different order' do
      expect(stack.cards.map{ |card| card.value }).not_to eq %w(H2 C3 S4 D5 JOKER)
    end
  end

  describe 'Find' do
    let(:cards) { cards_5_with_joker }

    it 'can find a contained card by value' do
      expect(stack.find(value: 'JOKER').value).to eq 'JOKER'
    end

    it 'can find a contained card by rank and suite' do
      #TODO: Must confirm everywhere that rank is an integer
      expect(stack.find(suite: 'C', rank: 3).value).to eq 'C3'
    end

    it 'returns nil if a card could not be found' do
      expect(stack.find(suite: 'H', rank: 'A')).to be_nil
    end
  end

  describe 'Remove by value' do
    let(:cards) { cards_5_with_joker }

    it 'returns the card that was removed' do
      expect(stack.remove_by_value('H2').value).to eq 'H2'
    end

    it 'removes the card' do
      stack.remove_by_value('H2')
      expect(stack.cards.map{ |card| card.value }).not_to include 'H2'
    end

    it 'only removes one card' do
      stack.remove_by_value('H2')
      expect(stack.length).to eq 4
    end
  end

  describe 'Sweep the stack' do
    let(:cards) { cards_5_with_joker }
    let!(:returned) { stack.sweep_from('S4') }

    it 'returns last 3 cards' do
      expect(returned.map {|card| card.value }).to eq ['S4', 'D5', 'JOKER']
    end

    it 'keep first 2 cards' do
      expect(stack.cards.map {|card| card.value }).to eq ['H2', 'C3']
    end
  end

  describe 'Pick' do
    let(:cards) { cards_5_with_joker }
    let(:picks) { ['C3', 'S4', 'D5'] }

    it 'can pick 3 cards' do
      expect(stack.pick(picks).map{|card| card.value}).to eq picks
    end

    it 'leaves cards behind' do
      stack.pick(picks)
      expect(stack.cards.map{|card| card.value}).to eq ['H2', 'JOKER']
    end
  end

  #TODO: Card owner
  #TODO: Card sort


  #TODO: common context: lower, higher, etc. stacks from line 192

  describe 'is_consecutive' do
    context 'has a mid stack' do
      it '' do
        expect(CardStack.is_consecutive([])).to be
      end
    end
  end

  describe 'can_meld' do
    context 'has no cards in rank meld yet' do
      let(:stack) { CardStack.new(rank: '4') }

      it 'can start a rank meld with 3' do
        cards_to_meld = [
            Card.new(suite: 'H', rank: '4', value: 'H4'),
            Card.new(suite: 'D', rank: '4', value: 'joker'),
            Card.new(suite: 'C', rank: '4', value: 'joker2')
        ]

        expect(stack.can_meld(cards_to_meld)).to be_truthy
      end

      it 'cannot start a rank-meld less than 3' do
        cards_to_meld = [
            Card.new(suite: 'H', rank: '4', value: 'H4'),
            Card.new(suite: 'D', rank: '4', value: 'D4')
        ]

        expect(stack.can_meld(cards_to_meld)).to be_falsey
      end
    end

    context 'has no cards in suite meld yet' do
      let(:stack) { CardStack.new }

      it 'can start a suite meld with 3' do

      end

      it 'cannot start a suite-meld less than 3' do

      end
    end

    context 'has a mid stack' do
      let(:stack) do
        new_stack = CardStack.new
        new_stack << Card.new(suite: 'H', rank: '5', value: 'H5')
        new_stack << Card.new(suite: 'H', rank: '6', value: 'H6')
        new_stack << Card.new(suite: 'H', rank: '7', value: 'H7')
        new_stack
      end
    end

    context 'has a low stack' do
      let(:cards) { cards_low }
    end

    context 'has a low stack with jokers' do
      let(:stack) do
        new_stack = CardStack.new
        new_stack << Card.new(suite: 'H', rank: 'A', value: 'joker')
        new_stack << Card.new(suite: 'H', rank: '2', value: 'H2')
        new_stack << Card.new(suite: 'H', rank: '3', value: 'joker2')
        new_stack
      end
    end

    context 'has a high stack' do
      let(:stack) do
        new_stack = CardStack.new
        new_stack << Card.new(suite: 'H', rank: 'Q', value: 'HQ')
        new_stack << Card.new(suite: 'H', rank: 'K', value: 'HK')
        new_stack << Card.new(suite: 'H', rank: 'A', value: 'HA')
        new_stack
      end
    end

    context 'has a high stack with jokers' do
      let(:stack) do
        new_stack = CardStack.new
        new_stack << Card.new(suite: 'H', rank: 'Q', value: 'joker')
        new_stack << Card.new(suite: 'H', rank: 'K', value: 'HK')
        new_stack << Card.new(suite: 'H', rank: 'A', value: 'joker2')
        new_stack
      end
    end

    context 'has a rollover stack' do
      let(:stack) do
        new_stack = CardStack.new
        new_stack << Card.new(suite: 'H', rank: 'Q', value: 'HQ')
        new_stack << Card.new(suite: 'H', rank: 'K', value: 'HK')
        new_stack << Card.new(suite: 'H', rank: 'A', value: 'HA')
        new_stack << Card.new(suite: 'H', rank: '2', value: 'H2')
        new_stack << Card.new(suite: 'H', rank: '3', value: 'H3')
        new_stack
      end
    end

    context 'has a rank stack' do
      let(:stack) do
        new_stack = CardStack.new
        new_stack << Card.new(suite: 'H', rank: '4', value: 'H4')
        new_stack << Card.new(suite: 'C', rank: '4', value: 'C4')
        new_stack << Card.new(suite: 'D', rank: '4', value: 'D4')
        new_stack
      end
    end

    context 'has a rank stack with jokers' do
      let(:stack) do
        new_stack = CardStack.new
        new_stack << Card.new(suite: 'H', rank: '4', value: 'H4')
        new_stack << Card.new(suite: 'C', rank: '4', value: 'joker')
        new_stack << Card.new(suite: 'D', rank: '4', value: 'joker2')
        new_stack
      end
    end
  end
end
