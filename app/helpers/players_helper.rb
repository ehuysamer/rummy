module PlayersHelper

  #TODO: move to Card.suite_to_name
  def suite_symbol(letter)
    {
        'S' => ['2660'.hex].pack('U'),
        'H' => ['2665'.hex].pack('U'),
        'D' => ['2666'.hex].pack('U'),
        'C' => ['2663'.hex].pack('U'),
        nil => '?',
        '' => '?'
    }[letter]
  end

  def joker_symbol
    ['1F0DF'.hex].pack('U')
  end

  def suite_color(letter)
    {
        'S' => 'blue',
        'H' => 'red',
        'D' => 'red',
        'C' => 'black',
        nil => 'gray',
        '' => 'gray'
    }[letter]
  end

  def card_button_text(card)
    return 'N/A' if card.nil?

    if card.suite.nil? || card.rank.nil?
      if card.joker
        joker_symbol
      else
        card.value
      end
    else
      #TODO: Sort this out
      '<span style="padding: 0; margin: 0; color: ' + suite_color(card.suite) + '">' + suite_symbol(card.suite) + '</span>' + Card.rank_to_name(card.rank)
    end
 end
end
