class JokerGrabController < ApplicationController
  include PlayerConcern

  def create
    return unless handle_can_play

    result = JokerGrab.new(round: @round, player: @player, card_submitted: params[:card], joker_id: Card::JOKER[0]).call ||
      JokerGrab.new(round: @round, player: @player, card_submitted: params[:card], joker_id: Card::JOKER[1]).call

    show_errors(['Unable to claw back the joker']) unless result

    redirect_to_current_round
  end
end
