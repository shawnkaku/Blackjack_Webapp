require_relative 'player'

class Dealer < Player

  def initialize
    #self.initialize("Dealer")
    @name = "Dealer"
    @hold_cards = Array.new
    self.init
    puts "dealer"
  end

  def dealer_rule(points)
    if (points > 17)
      return true
    else
      return false
    end
  end
end