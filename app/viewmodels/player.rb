class Player
  attr_reader :name
  attr_reader :melds
  attr_reader :hand

  #TODO: start_moves
  #TODO: has_discarded
  #TODO: card_must_use
  #TODO: end_moves

  #TODO: syncing inconsistency: player.melds and meld.owner
  def initialize(name, hand)
    @name = name
    @hand = hand
    @melds = []
  end
end
