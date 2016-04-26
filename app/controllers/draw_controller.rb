class DrawController < ApplicationController
  include PlayerConcern

  def create
    #NOTE: We don't allow undo if the player drew from the pickup stack (prevent cheating)

    can_play_service = CanPlay.new(round: @round, player: @player)

    if can_play_service.call
      Draw.new(@player, @round).call
    else
      flash[:notice] = @player.errors.join('<br/>')
    end

    redirect_to_current_round
  end
end
