require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'card'

class Blackjack
  attr_accessor :player, :dealer, :deck

  def initialize(i_deck, s_player)
    @deck = Deck.new(i_deck)
    @player = Player.new(s_player)
    @dealer = Dealer.new
    # @arr_p = Array.new
  end

  # def init_new
  #   @arr_p.clear
  #   @arr_p << @player1
  #   @arr_p << @dealer
  # end

  # def run
  #   choice = 1
  #   @dk.init_new(@player1, @dealer)
  #   init_new
  #   while choice != 3
  #     if @player1.status == "BST"
  #       choice = 2
  #       puts "#{@player1.name} is bust."
  #     else
  #       choice = @dk.choice
  #     end
  #     case
  #       when choice == 1
  #         if @dk.hit(@player1, true)
  #           @player1.status = "BST"
  #         end
  #       when choice == 2
  #         @dk.stay(@player1)
  #         # turn to dealer to do something
  #         loop do @dk.hit(@dealer, true)
  #         break if (@dealer.dealer_rule(@dk.calculate_point(@dealer.hold_cards)) == true)
  #         end
  #         # Compare which one is the winner in this turn
  #         puts "Winner is #{@dk.winner(@arr_p)}."
  #         puts "********  Start the new turn  ********"
  #         @player1.init()
  #         @dealer.init()
  #         @dk.init_new(@player1, @dealer)
  #         init_new
  #       when choice == 3
  #         @dk.quit(@player1)
  #       else
  #         puts "You didn't Enter any choice. Please Enter 1, 2, or 3."
  #     end
  #   end
  # end
end

# puts "============= Strat the BlackJack Game ============="
# puts "How many decks in this game?"
# decks = gets.chomp.to_i
# puts "Welcome to the BlackJack game. What's your name?"
# players = gets.chomp.to_s
# bj = Blackjack.new(decks, players)
# bj.run

