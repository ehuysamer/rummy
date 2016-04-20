class Card
  #TODO: Change to attr_reader; all except 'owner'
  attr_accessor :chosen
  attr_accessor :back
  attr_accessor :id
  attr_accessor :suite
  attr_accessor :rank
  attr_accessor :owner
  attr_accessor :joker

  #TODO: #REFACTOR: Change 'value' to 'id'

  def initialize(id: '', suite: nil, rank: nil, back: false, chosen: false, owner: nil, joker: false)
    @id = id
    @back = back
    @chosen = chosen
    @suite = suite
    @rank = rank
    @owner = owner
    @joker = joker
  end

  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITES = %w(S H C D)

  def score
    #TODO: #TEST: Score
    # Score is the impersonated score (outside the hand); or 50 if its inside the hand (no score)
    10 if rank && rank > 10
    50 if joker
    rank || 0
  end

  def self.rank_to_name(rank)
    RANKS[rank - 1]
  end

  def self.name_to_rank(name)
    RANKS.find_index(name) + 1
  end

  def self.suite_rank_to_id(suite, rank)
    suite + Card.rank_to_name(rank)
  end

  def self.rank_by_id(id)
    # [<JOKER>]<SUITE><RANK NAME>
    index = 0
    rank_name = nil

    # Joker (which is optional)
    if index < id.length && id[index].downcase == 'j'
      index += 1
    end

    # Suite
    if index < id.length
      index += 1
    end

    # Rank digit 1
    if index < id.length
      rank_name = id[index]
      index += 1
    end

    # Rank digit 2
    if index < id.length
      rank_name += id[index]
      index += 1
    end

    name_to_rank(rank_name) if rank_name && rank_name.length > 0
  end

  def self.suite_by_id(id)
    index = 0
    rank_name = nil

    # Joker (which is optional)
    if index < id.length && id[index].downcase == 'j'
      index += 1
    end

    # Suite
    if index < id.length
      id[index]
    else
      nil
    end
  end

  def self.create(suite: nil?, rank: nil?, joker: nil?)
    Card.new(id: suite_rank_to_id(suite, rank), suite: suite, rank: rank, joker: joker)
  end

  def self.create_from_id(id)
    suite = nil
    rank = Card.rank_by_id(id)

    if id[0] == 'J'
      suite = id[1] if id.length >= 2
      Card.new(suite: suite, rank: rank, id: 'JOKER', joker: true)
    else
      suite = id[0]
      Card.new(suite: suite, rank: rank, id: id) #(suite + rank.to_s))
    end
  end

  def compare_id_to(other)
    id == other.id
  end

  def compare_rank_suite_to(other)
    rank == other.rank && suite == other.suite
  end
end
