class PlayersController < ApplicationController
  include PlayerConcern

  def index
    redirect_to url_for(:controller => :players, :action => :show, :id => @round.player_id(@round.current_player), :game_id => @game_id)
  end

  #TODO: Don't put cards ids into html if cards' backs are turned

  def show
    @pickup = @round.pickup
    @discard = @round.discard
    @players = @round.players
  end

  def player_id
    player_params[:id]
  end
end

#     [
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false)
#     ],
#     [
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false)
#     ],
#     [
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
#         Card.new(value: suite+'A', back: false, selectable: true, chosen: false)
#     ]
# ]
