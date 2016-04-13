class Player
  attr_reader :name
  attr_reader :melds
  attr_reader :hand

  #TODO: syncing inconsistency: player.melds and meld.owner
  def initialize(name, hand)
    @name = name
    @hand = hand
    @melds = []
  end
end
