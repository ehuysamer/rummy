class ResetController < ApplicationController
  def create
    Round.reset(game_id: 1)

    redirect_to url_for(:controller => :players, :action => :show, :id => 0, :game_id => '1')
  end
end
