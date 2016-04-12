class PlayersController < ApplicationController
  def show
    round = Round.get(game_id: 1)

    @pickup = round.pickup
    @discard = round.discard

    @player2_melds = []

    @player_hands = round.player_hands

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
