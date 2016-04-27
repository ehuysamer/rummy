class DiscardController < ApplicationController
  include PlayerConcern

  def create
    return unless handle_can_play

    discard_service = Discard.new(round: @round, player: @player, card_id: params[:discard])

    if discard_service.call
      @round.next_player
    end

    show_errors(discard_service.errors)

    redirect_to_current_round
  end
end
