class DiscardController < ApplicationController
  include PlayerConcern

  def create
    can_play_service = CanPlay.new(round: @round, player: @player)

    if can_play_service.call
      discard_service = Discard.new(round: @round, player: @player, card_id: params[:discard])
    else
      flash[:notice] = can_play_service.errors.join('<br/>')
      redirect_to_current_round
      return
    end

    if discard_service.call
      @round.next_player
    else
      flash[:notice] = discard_service.errors.join('<br/>')
    end

    redirect_to_current_round
  end
end
