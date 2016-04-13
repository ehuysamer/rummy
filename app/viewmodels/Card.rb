class Card
  #TODO: Change to attr_reader; all except 'owner'
  attr_accessor :chosen
  attr_accessor :selectable
  attr_accessor :back
  attr_accessor :value
  attr_accessor :suite
  attr_accessor :rank
  attr_accessor :owner

  def initialize(value: '', suite: nil, rank: nil, back: false, selectable: true, chosen: false, owner: owner)
    @value = value
    @back = back
    @selectable = selectable
    @chosen = chosen
    @suite = suite
    @rank = rank
    @owner = owner
  end

  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)

  def self.rank_to_name(rank)
    RANKS[rank - 1]
  end

  def self.name_to_rank(name)
    RANKS.find_index(name) + 1
  end

  def self.suite_rank_to_value(suite, rank)
    suite + Card.rank_to_name(rank)
  end

  def self.rank_of_value(value)
    # [<JOKER>]<SUITE><RANK NAME>
    index = 0
    rank_name = nil

    # Joker (which is optional)
    if index < value.length && value[index].downcase == 'j'
      index += 1
    end

    # Suite
    if index < value.length
      index += 1
    end

    # Rank digit 1
    if index < value.length
      rank_name = value[index]
      index += 1
    end

    # Rank digit 2
    if index < value.length
      rank_name += value[index]
      index += 1
    end

    name_to_rank(rank_name) if rank_name && rank_name.length > 0
  end

  def self.create(suite: nil?, rank: nil?)
    Card.new(value: suite_rank_to_value(suite, rank), suite: suite, rank: rank)
  end

  def compare_value_to(other)
    value == other.value
  end

  def compare_rank_suite_to(other)
    rank == other.rank && suite == other.suite
  end
end
