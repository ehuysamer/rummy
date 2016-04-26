class Card
  attr_reader :id
  attr_reader :joker
  attr_reader :suite
  attr_reader :rank

  #TODO: Change to attr_reader; all except 'owner'
  attr_accessor :chosen
  attr_accessor :owner

  SPADES = 'S'
  HEARTS = 'H'
  CLUBS = 'C'
  DIAMONDS = 'D'

  RANKS = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITES = [SPADES, HEARTS, CLUBS, DIAMONDS]

  JOKER = %w(joker joker2)

  JOKER_SYMBOL = ['1F0DF'.hex].pack('U')

  def initialize(id: '', suite: nil, rank: nil, back: false, chosen: false, owner: nil, joker: false)
    @id = id
    @back = back
    @chosen = chosen
    @suite = suite
    @rank = rank
    @owner = owner
    @joker = joker
  end

  def self.suite_symbol(letter)
    {
        SPADES => ['2660'.hex].pack('U'),
        HEARTS => ['2665'.hex].pack('U'),
        DIAMONDS => ['2666'.hex].pack('U'),
        CLUBS => ['2663'.hex].pack('U'),
        nil => '?',
        '' => '?'
    }[letter]
  end

  def impersonate(suite: nil, rank: nil)
    if joker
      @suite = suite
      @rank = rank
    end
  end

  def score
    # Score is the impersonated score (outside the hand); or 50 if its inside the hand (no score)

    if joker && !rank
      50
    elsif rank && rank > 10
      10
    else
      rank || 0
    end
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

  def to_s
    if suite && rank
      Card::suite_symbol(suite) + Card.rank_to_name(rank)
    elsif joker
      JOKER_SYMBOL
    else
      card.id
    end
  end
end
