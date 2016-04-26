class JokerGrabController < ApplicationController
  include PlayerConcern

  def create
    JokerGrab.new(@round, @player, params[:card]).call

    redirect_to_current_round
  end
end
