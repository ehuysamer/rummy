class DrawDiscardedController < ApplicationController
  include PlayerConcern

  def create
    return unless handle_can_play

    SaveState.new(@round).call

    draw_discard_service = DrawDiscarded.new(player: @player, round: @round, card: params[:draw])
    draw_discard_service.call
    show_errors(draw_discard_service.errors)

    redirect_to_current_round
  end
end
