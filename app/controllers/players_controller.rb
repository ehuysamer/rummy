class PlayersController < ApplicationController
  def show
    @round = Round.get(game_id: 1)

    @player_id = params[:id].to_i
    @round.select_player(@round.players[@player_id])

    @pickup = @round.pickup
    @discard = @round.discard

    @players = @round.players

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

  end
end
