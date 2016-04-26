module PlayersHelper

  def joker_symbol
    ['1F0DF'.hex].pack('U')
  end

  def suite_color(card)
    {
        'S' => 'blue',
        'H' => 'red',
        'D' => 'red',
        'C' => 'black',
        nil => 'black',
        '' => 'black'
    }[card.suite]
  end

  #TODO: Consider either using card view or deleting card view
  def card_button_text(card, show_joker)
    return 'N/A' if card.nil?

    return '<span style="padding: 0; margin: 0; color: ' + suite_color(card) + '">' + card.to_s + '</span>'


    #TODO: Needs some fixing up
    if card.joker && show_joker
      Card::JOKER_SYMBOL
    elsif card.suite.nil? || card.rank.nil?
      if card.joker
        Card::JOKER_SYMBOL
      else
        card.id
      end
    else
      #TODO: Sort this out
      '<span style="padding: 0; margin: 0; color: ' + suite_color(card) + '">' + Card::suite_symbol(card.suite) + Card.rank_to_name(card.rank) + '</span>'
    end
  end
end
