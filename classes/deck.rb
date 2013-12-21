require_relative 'card'

class Deck
  attr_accessor :cards, :bust

  def initialize(num_decks)
    @max_point = 21
    @bust = false
    @cards = []
    ['H', 'D', 'S', 'C'].each do |suit|
      ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value|
        @cards << Card.new(suit, face_value)
      end
    end
    @cards = @cards * num_decks
    scramble!
  end

  def scramble!
    @cards.shuffle!
  end

  def deal
    @cards.pop
  end

  def winner(arr_player)
    arr_tmp_name = []
    arr_tmp_value = []
    arr_player.each do |player_obj|
      tmp_value = calculate_point(player_obj.hold_cards)
      if tmp_value <= @max_point
        arr_tmp_name << player_obj.name
        arr_tmp_value << tmp_value
      end
    end
    arr_tmp_name[arr_tmp_value.index(arr_tmp_value.max)]
  end

  # def is_bust(points)
  #   if points > @max_point
  #     return true
  #   else
  #     return false
  #   end
  # end

  def hit(player_obj)
    player_obj.hit(@cards.pop)
  end

  def deal
    @cards.pop
  end

  def calculate_point(arr_card)
    points = 0
    arr_card.each do |ca|
      if ca.suit == "A"
        points += 11
        points -= 10 if points > @max_point
      elsif ca.face_value.to_i == 0
        points += 10
      else
        points += ca.face_value.to_i
      end
    end
    return points
  end

end