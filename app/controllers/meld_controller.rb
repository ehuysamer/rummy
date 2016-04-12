class MeldController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    #cards_to_meld =  player_hands[0].find(value: )
    #round.discard << round.player_hands[0].remove_by_value(params[:discard])

    picked = round.player_hands[0].pick(params[:cards].map {|k,v| k})
    round.discard.concat(picked)

    #byebug

    redirect_to url_for(:controller => :players, :action => :show, :id => '1', :game_id => '1')
  end
end
