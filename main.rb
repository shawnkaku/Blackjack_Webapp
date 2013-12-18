require 'rubygems'
require 'sinatra'
# require 'pry'
require_relative 'classes/player'
require_relative 'classes/dealer'
require_relative 'classes/deck'
require_relative 'classes/blackjack'

set :sessions, true
MAX_POINT = 21


helpers do
  def calculate_point(arr_card)
    points = 0
    arr_card.each do |card|
      if card.suit == "A"
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
end

get '/' do
  if session[:player_name]
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

  session[:player_name] = params[:player_name]
  redirect '/game'
end

get '/game' do

  # @bj = Blackjack.new(3, session[:player_name])
  @deck = Deck.new(3)
  @player = Player.new(session[:player_name])
  @dealer = Dealer.new

  @deck.hit(@player)
  @deck.hit(@player)
  @deck.hit(@dealer)
  @deck.hit(@dealer)

  erb :game
end
