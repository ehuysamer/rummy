class Player
  attr_reader :name
  attr_reader :melds
  attr_reader :hand

  def initialize(name, hand)
    @name = name
    @hand = hand
    @melds = []
  end
end
