class DrawCardController < ApplicationController
  include PlayerConcern

  #TODO: RENAME TO DrawCardController

  def create
    #NOTE: We don't allow undo if the player drew from the pickup stack (prevent cheating)

    return unless handle_can_play

    DrawCard.new(@player, @round).call

    redirect_to_current_round
  end
end
