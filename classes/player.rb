class Player
  #includ calculate_point
  attr_accessor :name, :status, :hold_cards, :money, :turn_bet

  def initialize(name)
    @name = name
    self.money = 500
    self.turn_bet = 0
    # Player got all cards.
    @hold_cards = Array.new
    init
  end

  def init
    # "RUN" => OK, "BST" => bust
    @status = "RUN"
    self.turn_bet = 0
    # Player got all cards.
    @hold_cards.clear()
    # Player's point of this turn.
  end

  def hit(card)
    @hold_cards.push(card)
  end

  def win
    self.money += (self.turn_bet * 1.5).to_i
    self.turn_bet = 0
  end

  def loss
    self.turn_bet = 0
  end

  def tie
    self.money += self.turn_bet
    self.turn_bet = 0
  end

  def win_bet
    (self.turn_bet * 1.5).to_i
  end

  def bet(bet_money)
    self.turn_bet = bet_money
    self.money -= self.turn_bet
  end

end