class CardStack
  attr_reader :cards
  attr_reader :rank, :suite

  delegate :each, :length, :<<, :pop, :concat, to: :cards

  def initialize(rank: nil, suite: nil, cards: nil)
    @cards = []
    @cards.concat(cards) unless cards.nil?

    @rank = rank
    @suite = suite
  end

  def can_meld(cards_to_check)
    #WRONG: This will pass because rank.nil? is true if this is a stack for suites
    #cards.all? { |card| card.rank == rank || card.suite == suite || card.value == 'joker' || card.value == 'joker2' }

    if cards.length == 0 && cards_to_check.length < 3
      return false
    end

    if suite
      cards_to_check.all? { |card| card.suite == suite || card.value == 'joker' || card.value == 'joker2' }
    elsif rank
      cards_to_check.all? { |card| card.rank == rank || card.value == 'joker' || card.value == 'joker2' }
    end
  end

  def self.is_consecutive(cards)

  end

  def add_all
    %w(H C D S).each do |suite|
      (1..13).to_a.each do |rank|
        @cards << Card.new(suite: suite, rank: rank, value: Card.suite_rank_to_value(suite, rank))
      end
    end

    @cards << Card.new(value: 'joker')
    @cards << Card.new(value: 'joker2')
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

  def pick(values)
    picked = @cards.select{ |card| values.include?(card.value) }
    @cards -= picked
    picked
  end

  def to_s
    @cards.map { |card| card.value }.to_s
  end

  #TODO: IsTop(Card)
  #TODO: Sort + methods of sorting
end
