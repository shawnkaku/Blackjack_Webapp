class Player
  #includ calculate_point
  attr_accessor :name, :status, :hold_cards

  def initialize(name)
    @name = name
    # Player got all cards.
    @hold_cards = Array.new
    init
  end

  def init
    # "RUN" => OK, "BST" => bust
    @status = "RUN"
    # Player got all cards.
    @hold_cards.clear()
    # Player's point of this turn.
  end

  def hit(card)
    @hold_cards.push(card)
  end

end