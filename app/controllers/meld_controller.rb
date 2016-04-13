class MeldController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    picked = round.player_hands[0].pick(params[:cards].map {|k,v| k})

    meld = round.find_meld(picked)
    meld.concat(picked)

    redirect_to url_for(:controller => :players, :action => :show, :id => '1', :game_id => '1')
  end
end

#TODO: meld owner
#TODO: card owner
