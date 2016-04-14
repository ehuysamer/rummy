class DiscardController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    player_id = params[:player_id].to_i
    #round.select_player(round.players[player_id])

    Discard.new(round: round, player: round.players[player_id], card_value: params[:discard]).call

    redirect_to url_for(:controller => :players, :action => :show, :id => round.current_player.id, :game_id => '1')
  end
end
