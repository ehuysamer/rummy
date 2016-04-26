class JokerGrabController < ApplicationController
  include PlayerConcern

  def create
    JokerGrab.new(round: @round, player: @player, joker_id: params[:card]).call

    redirect_to_current_round
  end
end
