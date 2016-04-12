class Card
  attr_accessor :chosen
  attr_accessor :selectable
  attr_accessor :back
  attr_accessor :value
  attr_accessor :suite
  attr_accessor :rank

  def initialize(value: '', suite: nil, rank: nil, back: false, selectable: true, chosen: false)
    @value = value
    @back = back
    @selectable = selectable
    @chosen = chosen
    @suite = suite
    @rank = rank
  end

  def compare_value_to(other)
    value == other.value
  end

  def compare_rank_suite_to(other)
    rank == other.rank && suite == other.suite
  end
end
