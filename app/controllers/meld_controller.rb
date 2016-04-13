class MeldController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    picked = round.current_player.hand.pick(params[:cards].map {|k,v| k})

    Meld.new(round: round, player: round.current_player, cards: picked).call()

    redirect_to url_for(:controller => :players, :action => :show, :id => '1', :game_id => '1')
  end
end
