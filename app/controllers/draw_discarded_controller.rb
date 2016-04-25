class DrawDiscardedController < ApplicationController
  include PlayerConcern

  def create
    draw_discard_service = DrawDiscarded.new(player: @player, round: @round, card: params[:draw])
    if !draw_discard_service.call
      flash[:notice] = draw_discard_service.errors.join('<br/>')
    end

    #TODO: Prevent user from sweeping > 1 if he can't possibly use the card(s)
    #TODO: Prevent user from melding if it will prevent him from using the "force" card

    redirect_to url_for(:controller => :players, :action => :show, :id => @round.current_player_id, :game_id => @game_id)
  end
end
