class DrawController < ApplicationController
  include PlayerConcern

  def create
    #NOTE: We don't allow undo if the player drew from the pickup stack (prevent cheating)

    Draw.new(@player, @round).call

    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end
end
