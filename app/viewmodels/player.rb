class Player
  attr_reader :id
  attr_reader :name
  attr_reader :hand

  attr_reader :round

  attr_accessor :has_drawn_card
  attr_accessor :card_must_use

  #TODO: card_must_use

  def initialize(id, name, hand, round)
    @id = id
    @name = name
    @hand = hand
    @melds = []
    @has_drawn_card = false
    @card_must_use = false
    @round = round
  end

  def won?
    hand.cards.length == 0
  end

  def melds
    round.melds.select{|meld| meld.owner == self}
  end
end
