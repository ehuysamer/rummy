class CardStack
  attr_reader :cards
  attr_reader :rank, :suite
  attr_accessor :owner

  delegate :each, :length, :<<, :pop, :concat, to: :cards

  def initialize(rank: nil, suite: nil, cards: nil)
    @cards = []
    @cards.concat(cards) unless cards.nil?

    @rank = rank
    @suite = suite

    @owner = nil
  end

  def can_meld(cards_to_check)
    #WRONG: This will pass because rank.nil? is true if this is a stack for suites
    #cards.all? { |card| card.rank == rank || card.suite == suite || card.value == 'joker' || card.value == 'joker2' }

    if cards.length == 0 && cards_to_check.length < 3
      return false
    end

    if suite
      if cards_to_check.all? { |card| card.suite == suite || card.value == 'joker' || card.value == 'joker2' }
        test_list = cards.clone.concat(cards_to_check)
        CardStack.is_consecutive test_list
      end
    elsif rank
      cards_to_check.all? { |card| card.rank == rank || card.value == 'joker' || card.value == 'joker2' }
    end
  end

  def self.rank_inc(rank)
    (rank % 13) + 1
  end

  def self.rank_dec(rank)
    (rank - 2) % 13 + 1
  end

  #TODO: Impact of jokers
  def self.is_adjacent(card1, card2)
    (card1.rank - card2.rank).abs == 1  || rank_inc(card1.rank) == card2.rank || rank_dec(card1.rank) == card2.rank
  end

  def self.move_any_adjacent_card(cards, target)
    return nil if cards.length == 0

    if target.length == 0
      card = cards.shift
      target << card
      card
    else
      cards.each do |card|
        target.each do |already_there_card|
          #byebug

          if is_adjacent(card, already_there_card)
            cards.delete_if {|card_to_check| card.value == card_to_check.value }
            target << card
            return card
          end
        end
      end

      nil
    end
  end

  def self.is_consecutive(cards)
    ranks = cards.clone
    found = []

    while move_any_adjacent_card(ranks, found) do
    end

    ranks.length == 0
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

  def sorted
    c1 = nil
    c2 = nil

    @cards.dup.sort do |card1, card2|
      c1 = card1
      c2 = card2

      if card1.suite != card2.suite
        card1.suite <=> card2.suite || 0
      else
        card1.rank <=> card2.rank || 0
      end
    end

  rescue
    byebug
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
