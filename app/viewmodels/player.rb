class Player
  attr_reader :id
  attr_reader :name
  attr_reader :melds
  attr_reader :hand

  attr_accessor :has_drawn_card
  attr_accessor :card_must_use

  #TODO: card_must_use
  #TODO: has_drawn
  #TODO: end_moves
  #TODO: Player order of game completion
  #TODO: Game ended marker

  #TODO: Disable player inputs if not his turn

  #TODO: syncing inconsistency: player.melds and meld.owner
  def initialize(id, name, hand)
    @id = id
    @name = name
    @hand = hand
    @melds = []
    @has_drawn_card = false
    @card_must_use = false
  end
end
