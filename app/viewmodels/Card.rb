class Card
  #TODO: Change to attr_reader; all except 'owner'
  attr_accessor :chosen
  attr_accessor :back
  attr_accessor :value
  attr_accessor :suite
  attr_accessor :rank
  attr_accessor :owner
  attr_accessor :joker

  #TODO: #REFACTOR: Change 'value' to 'id'

  def initialize(value: '', suite: nil, rank: nil, back: false, chosen: false, owner: nil, joker: false)
    @value = value
    @back = back
    @chosen = chosen
    @suite = suite
    @rank = rank
    @owner = owner
    @joker = joker
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

  def self.suite_of_value(value)
    index = 0
    rank_name = nil

    # Joker (which is optional)
    if index < value.length && value[index].downcase == 'j'
      index += 1
    end

    # Suite
    if index < value.length
      value[index]
    else
      nil
    end
  end

  def self.create(suite: nil?, rank: nil?, joker: nil?)
    Card.new(value: suite_rank_to_value(suite, rank), suite: suite, rank: rank, joker: joker)
  end

  def self.create_from_value(value)
    suite = nil
    rank = Card.rank_of_value(value)

    if value[0] == 'J'
      suite = value[1] if value.length >= 2
      Card.new(suite: suite, rank: rank, value: 'JOKER', joker: true)
    else
      suite = value[0]
      Card.new(suite: suite, rank: rank, value: value) #(suite + rank.to_s))
    end
  end

  def compare_value_to(other)
    value == other.value
  end

  def compare_rank_suite_to(other)
    rank == other.rank && suite == other.suite
  end
end
