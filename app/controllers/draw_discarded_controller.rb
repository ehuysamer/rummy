class DrawDiscardedController < ApplicationController
  include PlayerConcern

  def create
    DrawDiscarded.new(player: @player, round: @round, card: params[:draw]).call
    
    redirect_to url_for(:controller => :players, :action => :show, :id => @player_id, :game_id => @game_id)
  end
end
