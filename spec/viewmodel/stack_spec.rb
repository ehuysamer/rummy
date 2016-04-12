require 'rails_helper'

RSpec.describe Stack, type: :class do
  #include ApplicationHelper

  let(:stack) do
    new_stack = Stack.new
    new_stack << Card.new(suite: 'H', rank: '2', value: 'H2')
    new_stack << Card.new(suite: 'C', rank: '3', value: 'C3')
    new_stack << Card.new(suite: 'S', rank: '4', value: 'S4')
    new_stack << Card.new(suite: 'D', rank: '5', value: 'D5')
    new_stack << Card.new(suite: nil, rank: nil, value: 'JOKER')
    new_stack
  end

  describe 'Initialize' do
    it 'empty' do
      expect(Stack.new.cards.length).to eq 0
    end
  end

  describe 'Add all' do
    let(:stack) { Stack.new }

    before { stack.add_all }

    it 'to have everything' do
      expect(stack.cards.length).to eq 54
    end
  end

  describe 'Push' do
    let(:stack) { Stack.new }

    before do
      stack << Card.new(suite: 'H', rank: '2', value: 'H2')
      stack << Card.new(suite: 'C', rank: '3', value: 'C3')
    end

    it 'has two cards' do
      expect(stack.cards.length).to eq 2
    end

    it 'has cards in correct order' do
      expect(stack.cards.map{ |card| card.value }).to eq %w(H2 C3)
    end
  end

  describe 'Pop' do
    before do
      stack << Card.new(suite: 'H', rank: '2', value: 'H2')
      stack << Card.new(suite: 'C', rank: '3', value: 'C3')
    end

    it 'pops the last card first' do
      expect(stack.pop.value).to eq 'C3'
    end

    it 'pops the first card next' do
      stack.pop
      expect(stack.pop.value).to eq 'H2'
    end
  end

  describe 'Shuffle' do
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
    it 'can find a contained card by value' do
      expect(stack.find(value: 'JOKER').value).to eq 'JOKER'
    end

    it 'can find a contained card by rank and suite' do
      expect(stack.find(suite: 'C', rank: '3').value).to eq 'C3'
    end

    it 'returns nil if a card could not be found' do
      expect(stack.find(suite: 'H', rank: 'A')).to be_nil
    end
  end

  describe 'Remove by value' do
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
    let!(:returned) { stack.sweep_from('S4') }

    it 'returns last 3 cards' do
      expect(returned.map {|card| card.value }).to eq ['S4', 'D5', 'JOKER']
    end

    it 'keep first 2 cards' do
      expect(stack.cards.map {|card| card.value }).to eq ['H2', 'C3']
    end
  end
end
