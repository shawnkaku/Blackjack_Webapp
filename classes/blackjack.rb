require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'

class Blackjack
  attr_accessor :player, :dealer, :deck, :player_turn, :arr_p

  def initialize(i_deck, s_player)
    @deck = Deck.new(i_deck)
    @player = Player.new(s_player)
    @dealer = Dealer.new
    # self.player_turn = true
    self.arr_p = Array.new
    init_new
  end

  def init_new
    @arr_p.clear
    @arr_p << @player
    @arr_p << @dealer
  end

end


