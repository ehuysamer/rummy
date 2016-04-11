require 'rails_helper'

RSpec.describe Stack, type: :class do
  #include ApplicationHelper

  let(:stack) { Stack.new }

  describe 'Initialize' do
    it 'empty' do
      expect(stack.cards.length).to eq 0
    end
  end

  describe 'Add all' do
    before { stack.add_all }

    it 'to have everything' do
      expect(stack.cards.length).to eq 54
    end
  end

  describe 'Push' do
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
      stack << Card.new(suite: 'H', rank: '2', value: 'H2')
      stack << Card.new(suite: 'C', rank: '3', value: 'C3')
      stack << Card.new(suite: 'S', rank: '4', value: 'S4')
      stack << Card.new(suite: 'D', rank: '5', value: 'D5')
      stack.shuffle
    end

    it 'still has 4 cards' do
      expect(stack.cards.length).to eq 4
    end

    it 'still has each card cards' do
      expect(stack.cards.map{ |card| card.value }).to include 'H2'
      expect(stack.cards.map{ |card| card.value }).to include 'C3'
      expect(stack.cards.map{ |card| card.value }).to include 'S4'
      expect(stack.cards.map{ |card| card.value }).to include 'D5'
    end

    it 'has a different order' do
      expect(stack.cards.map{ |card| card.value }).not_to eq %w(H2 C3 S4 D5)
    end
  end
end
