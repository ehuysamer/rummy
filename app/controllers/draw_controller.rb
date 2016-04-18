class DrawController < ApplicationController
  include PlayerConcern

  def create
    Draw.new(@player, @round).call

    redirect_to url_for(:controller => :players, :action => :show, :id => @player_id, :game_id => @game_id)
  end
end
