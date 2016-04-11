class PlayersController < ApplicationController
  def show
    @pickup = [
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: false),
        Card.new(back: true, selectable: true),
    ]

    suite = 'S'

    @discard = [
        Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'2', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'3', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'4', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'5', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'6', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'7', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'8', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'9', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'2', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'3', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'4', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'5', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'6', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'7', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'8', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'9', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'2', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'3', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'4', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'5', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'6', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'7', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'8', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'9', back: false, selectable: true, chosen: false),

        Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'2', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'3', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'4', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'5', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'6', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'7', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'8', back: false, selectable: true, chosen: false),
        Card.new(value: suite+'9', back: false, selectable: true, chosen: false),
    ]

    @player1 = @discard.clone.map{ |c| result = Card.new(value: 'SA', back: false, chosen: false, selectable: true); result }
    @player1[5].chosen = true;

    @player2 = @discard.clone.map{ |c| result = Card.new(value: c.value, back: true, chosen: false, selectable: false); result }
    @player3 = @discard.clone.map{ |c| result = Card.new(value: c.value, back: true, chosen: false, selectable: false); result }
    @player4 = @discard.clone.map{ |c| result = Card.new(value: c.value, back: true, chosen: false, selectable: false); result }

    @player2_melds = [
        [
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false)
        ],
        [
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false)
        ],
        [
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false),
            Card.new(value: suite+'A', back: false, selectable: true, chosen: false)
        ]
    ]

  end
end
