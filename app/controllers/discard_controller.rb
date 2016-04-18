class DiscardController < ApplicationController
  include PlayerConcern

  def create
    Discard.new(round: @round, player: @player, card_value: params[:discard]).call

    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end
end
