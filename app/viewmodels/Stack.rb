class Stack
  attr_reader :cards

  delegate :each, :length, :<<, :pop, :concat, to: :cards

  def initialize
    @cards = []
  end

  def add_all
    %w(H C D S).each do |suite|
      %w(A 2 3 4 5 6 7 8 9 10 J Q K).each do |rank|
        @cards << Card.new(suite: suite, rank: rank, value: suite + rank)
      end
    end

    @cards << Card.new(value: 'joker')
    @cards << Card.new(value: 'joker')
  end

  def shuffle
    @cards.shuffle!
  end

  def find(value: nil, rank: nil, suite: nil)
    @cards.find{ |card| (value.nil? || card.value == value) && (rank.nil? || card.rank == rank) && (suite.nil? || card.suite == suite)}
  end

  def remove_by_value(value)
    card_found = find(value: value)
    @cards.reject!{ |card| card.compare_value_to(card_found) }
    card_found
  end

  def sweep_from(value)
    position = @cards.find_index{ |card| card.value == value }
    returned = @cards.last(@cards.length - position)
    @cards = @cards - returned
    returned
  end

  #TODO: IsTop(Card)
  #TODO: Sort + methods of sorting
end
