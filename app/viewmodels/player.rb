class Player
  attr_reader :id
  attr_reader :name
  attr_reader :melds
  attr_reader :hand

  #TODO: start_moves
  #TODO: has_discarded
  #TODO: card_must_use
  #TODO: has_drawn
  #TODO: end_moves

  #TODO: syncing inconsistency: player.melds and meld.owner
  def initialize(id, name, hand)
    @id = id
    @name = name
    @hand = hand
    @melds = []
  end
end
