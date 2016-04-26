class DrawDiscardedController < ApplicationController
  include PlayerConcern

  def create
    SaveState.new(@round).call

    draw_discard_service = DrawDiscarded.new(player: @player, round: @round, card: params[:draw])
    if !draw_discard_service.call
      flash[:notice] = draw_discard_service.errors.join('<br/>')
    end

    redirect_to_current_round
  end
end
