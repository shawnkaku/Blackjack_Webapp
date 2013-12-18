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

  def init_new(player_obj1, player_obj2)
    hit(player_obj1, true)
    hit(player_obj2, false)
    @bust = false
  end

  def scramble!
    @cards.shuffle!
  end

  def deal
    @cards.pop
  end

  def choice
    puts "========= Choice Your Action ========="
    puts "1) for bit, 2) for stay, 3) for exit"
    return gets.chomp.to_i
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

  def player_status(player_obj)
    player_obj.hold_cards.each do |ca|
      puts "#{player_obj.name}\'s cards is #{ca.suit}, #{ca.face_value}"
    end
    puts "#{player_obj.name}\'s point is #{calculate_point(player_obj.hold_cards)}."
    puts "-------------------------------"
  end

  def is_bust(points)
    if points > @max_point
      return true
    else
      return false
    end
  end

  def hit(player_obj)
    player_obj.hit(@cards.pop)
    # if (is_show)
    #   player_status(player_obj)
    # end
    # return is_bust(calculate_point(player_obj.hold_cards))
  end

  def deal
    @cards.pop
  end

  def stay(player_obj)
    puts "#{player_obj.name} has finished this round."
  end

  def quit(player_obj)
    puts "Thanks for your join the game. Bye!"
    exit
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