class PlayersController < ApplicationController
  include PlayerConcern

  def show
    @pickup = @round.pickup
    @discard = @round.discard
    @players = @round.players
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
