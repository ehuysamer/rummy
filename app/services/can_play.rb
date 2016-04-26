class CanPlay
  attr_reader :errors

  def initialize(round: round, player: player)
    @round = round
    @player = player
    @errors = []
  end

  def call
    if player != round.current_player
      errors << "It is currently another player's turn"
      return false
    end

    if round.player_won
      errors << "The current round has already been won by '#{round.player_won.name}'"
      return false
    end

    true
  end

  private

  attr_reader :round, :player
end
