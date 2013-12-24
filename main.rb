require 'rubygems'
require 'sinatra'
require 'pry'

require_relative 'classes/player'
require_relative 'classes/dealer'
require_relative 'classes/deck'
require_relative 'classes/blackjack'

set :sessions, true
MAX_POINT = 21
DEALER_LIMIT = 17

helpers do
  def calculate_point(arr_card)
    #binding.pry
    points = 0
    arr_card.each do |card|
      if card.face_value == "A"
        points += 11
        points -= 10 if points > MAX_POINT
      elsif card.face_value.to_i == 0
        points += 10
      else
        points += card.face_value.to_i
      end
    end
    points
  end

  def card_img(card, show=true)
    suit = case card.suit
      when 'H' then 'hearts'
      when 'D' then 'diamonds'
      when 'C' then 'clubs'
      when 'S' then 'spades'
    end

    value = card.face_value
    if ['J', 'Q', 'K', 'A'].include?(value)
      value = case card.face_value
        when 'J' then 'jack'
        when 'Q' then 'queen'
        when 'K' then 'king'
        when 'A' then 'ace'
      end
    end

    if show
      "<img src='/images/cards/#{suit}_#{value}.jpg' class='card_image'>"
    else
      "<img src='/images/cards/cover.jpg' class='card_image'>"
    end
  end

  def is_bust(player_obj)
    point = calculate_point(player_obj.hold_cards)
    if point > MAX_POINT
      true
    else
      false
    end
  end

  def is_dealer_turn
    dealer_point = calculate_point(@dealer.hold_cards)
    player_point = calculate_point(@player.hold_cards)
    if (!session[:player_turn]) && (dealer_point < DEALER_LIMIT || dealer_point < player_point)
      if is_bust(@dealer)
        false
      else
        true
      end
    else
      false
    end
  end

  before do
    restore
  end

  def check_dealer
    dealer_point = calculate_point(@dealer.hold_cards)
    player_point = calculate_point(@player.hold_cards)
    if is_bust(@dealer)
      @success = "You win! Dealer look like Bust."
      session[:turn_over] = true
    elsif (dealer_point >= DEALER_LIMIT && dealer_point >= player_point)
      who_win
    end
  end

  def who_win
    session[:turn_over] = true
    winner = @deck.winner(@arr_p)
    if winner == "Dealer"
      @error = "#{winner} won this turn. You loss!"
    elsif winner != nil
      @success = "The winner is #{winner}."
    else
      @info = "Tie!"
    end
  end

  def reset_all
    session[:game] = nil
    session[:player_turn] = nil
    session[:turn_over] = false
  end

  def restore
    if session[:game]
      @game = session[:game]
      @player = @game.player
      @dealer = @game.dealer
      @deck = @game.deck
      @arr_p = @game.arr_p
      # @is_player_turn = @game.player_turn
    end
  end

  def save
    session[:game] = @game
    session[:player_turn] = true
    session[:turn_over] = false
  end

  def start_new_turn
    @game.init_new
    @player.init
    @dealer.init
  end

end

get '/' do
  if @game != nil
    redirect '/game'
  else
    redirect '/new_player'
  end
end

get '/new_player' do
  erb :new_player
end

get '/new_turn' do
  start_new_turn
  save
  restore
  redirect '/game'
end

post '/new_player' do
  if params[:player_name].empty?
    @error = "Name is required!"
    halt erb(:new_player)
  end

  @game = Blackjack.new(3, params[:player_name])
  save
  restore
  redirect '/game'
end

get '/game' do
  @deck.hit(@player)
  @deck.hit(@player)
  @deck.hit(@dealer)
  @deck.hit(@dealer)
  erb :game
end

post '/game/player/hit' do
  @deck.hit(@player)
  if is_bust(@player)
    @error = "Player look like Bust."
    session[:player_turn] = false
    session[:turn_over] = true
  end
  erb :game
end

post '/game/dealer/hit' do
  @deck.hit(@dealer)
  check_dealer
  erb :game
end

post '/game/dealer/stay' do
  who_win
  erb :game
end

post '/game/player/stay' do
  session[:player_turn] = false
  check_dealer
  erb :game
end

get '/game_over' do
  reset_all
  erb :game_over
end

get '/start_over' do
  reset_all
  redirect '/'
end

