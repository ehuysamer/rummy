class NextRoundController < ApplicationController
  include PlayerConcern

  def create
    @round.players.each { |player| player.apply_score }
    @round.reset_stacks
    @round.shuffle
    @round.deal

    redirect_to_current_round
  end
end
