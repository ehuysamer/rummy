class JokerGrabController < ApplicationController
  include PlayerConcern

  def create
    result = JokerGrab.new(round: @round, player: @player, card_submitted: params[:card], joker_id: Card::JOKER[0]).call ||
      JokerGrab.new(round: @round, player: @player, card_submitted: params[:card], joker_id: Card::JOKER[1]).call

    if !result
      flash[:notice] = 'Unable to claw back the joker'
    end

    redirect_to_current_round
  end
end
