class JokerImpersonate
  def initialize(round, player, joker1, joker2)
    @round = round
    @player = player
    @joker1 = joker1
    @joker2 = joker2
  end

  def call
    #TODO: Check if joker is in particular players' hand

    if @joker1
      card = @round.find_card(id: 'joker')
      card.rank = Card.rank_by_id(@joker1)
      card.suite = Card.suite_by_id(@joker1)
    end

    if @joker2
      card = @round.find_card(id: 'joker2')
      card.rank = Card.rank_by_id(@joker2)
      card.suite = Card.suite_by_id(@joker2)
    end

    true
  end
end
