class ResetController < ApplicationController
  def index
    Round.reset(game_id: params[:game_id])

    redirect_to url_for(:controller => :players, :action => :show, :id => 0, :game_id => @params[:game_id])
  end
end
