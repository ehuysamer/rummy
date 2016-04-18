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
      card = @round.find_card(value: 'joker')
      card.rank = Card.rank_of_value(@joker1)
      card.suite = Card.suite_of_value(@joker1)
    end

    if @joker2
      card = @round.find_card(value: 'joker2')
      card.rank = Card.rank_of_value(@joker2)
      card.suite = Card.suite_of_value(@joker2)
    end

    true
  end
end
