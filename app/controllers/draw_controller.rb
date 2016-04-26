class DrawController < ApplicationController
  include PlayerConcern

  #TODO: Don't show chosen cards for other players; i.e. when backs are shown

  def create
    SaveState.new(@round).call
    Draw.new(@player, @round).call

    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end
end
