class Player
  attr_reader :id
  attr_reader :name
  attr_reader :hand

  attr_reader :round

  attr_accessor :has_drawn_card
  attr_accessor :card_must_use

  attr_accessor :card_must_use_id

  def initialize(id, name, hand, round)
    @id = id
    @name = name
    @hand = hand
    @has_drawn_card = false
    @round = round

    card_must_use nil
  end

  def won?
    hand.cards.length == 0
  end

  def melds
    round.melds.select{|meld| meld.owner == self}
  end

  def card_must_use(id)
    @card_must_use_id = id
  end

  def score_in_hand
    @hand.cards.compact.reduce(0){ |sum, card| sum += (card.score || 0) }
  end

  def score_on_table
    @round.melds.compact.reduce(0) do |sum_melds, meld|
      sum_melds + meld.cards.compact.reduce(0) do |sum, card|
        if card.owner == self
          sum + card.score if card.owner == self
        else
          sum
        end
      end
    end
  end

  def score
    score_on_table - score_in_hand
  end
end
