class JokerImpersonate
  attr_reader :errors

  def initialize(round: nil, player: nil, joker_id: nil, value: nil)
    @round = round
    @player = player
    @joker_id = joker_id
    @value = value
    @errors = []
  end

  def call
    if (card = player.hand.find(id: joker_id))
      rank = Card.rank_by_id(@value)
      suite = Card.suite_by_id(@value)
      card.impersonate(rank: rank, suite: suite)
    else
      @errors << "You cannot set the replacement card for a joker that you don't own"
      return false
    end

    true
  end

  private

  attr_reader :player, :joker_id, :value
end
