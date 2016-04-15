class DrawController < ApplicationController
  def create
    round = Round.get(game_id: 1)

    player_id = params[:player_id].to_i
    player = round.players[player_id]

    player.has_drawn_card = true

    #TODO: When no cards left to draw, turn around discard stack
    #TODO: Naming consistency; stack -> card_stack

    round.select_player(player)

    card = round.pickup.pop
    card.chosen = true
    round.selected_player.hand << card

    redirect_to url_for(:controller => :players, :action => :show, :id => player_id, :game_id => '1')
  end
end
