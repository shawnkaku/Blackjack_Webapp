require 'rubygems'
require 'sinatra'
require 'pry'

require_relative 'classes/player'
require_relative 'classes/dealer'
require_relative 'classes/deck'
require_relative 'classes/blackjack'

set :sessions, true
MAX_POINT = 21


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

  def card_img(card)
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

    "<img src='/images/cards/#{suit}_#{value}.jpg' class='card_image'>"
  end

  before do
    restore
  end

  def reset_all
    session[:game] = nil
  end

  def restore
    if session[:game]
      @game = session[:game]
      #@game = Blackjack.new(3, params[:player_name])
      @player = @game.player
      @dealer = @game.dealer
      @deck = @game.deck
    end
  end

  def set_game
    session[:game] = @game
  end
end

get '/' do
  #if session[:game] != nil
  if @game != nil
    redirect '/game'
  else
    redirect '/new_player'
  end
end

get '/new_player' do
  erb :new_player
end

post '/new_player' do
  if params[:player_name].empty?
    @error = "Name is required!"
    halt erb(:new_player)
  end

  @game = Blackjack.new(3, params[:player_name])
  set_game
  restore
  redirect '/game'
end

get '/game' do

  @deck.hit(@player)
  @deck.hit(@player)
  @deck.hit(@dealer)
  @deck.hit(@dealer)

  erb :game
  #binding.pry
end

post '/game/player/hit' do
  @deck.hit(@player)
  erb :game
end

post '/game/player/stay' do
  # turn to dealer
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

