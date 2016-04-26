class DiscardController < ApplicationController
  include PlayerConcern

  def create
    discard_service = Discard.new(round: @round, player: @player, card_id: params[:discard])

    if discard_service.call
      @round.next_player
    else
      flash[:notice] = discard_service.errors.join('<br/>')
    end

    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end
end
