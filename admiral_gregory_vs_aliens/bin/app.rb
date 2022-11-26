# frozen_string_literal: true

require 'sinatra'
require 'base64'
require './bin/rubyorg/map'
require 'hero_room'

set :port, 8080
set :static, true
set :public_folder, 'static'
set :views, 'views'
enable :sessions
set :session_secret, SecureRandom.hex(64)

get '/' do
  session[:room] = 'START'
  redirect to('/game')
end

get '/game' do
  room = Map::GameRoom.load_room(session)

  if room
    erb :show_room, :locals => { :room => room }
  else
    erb :you_died
  end
end

post '/game' do
  room = Map::GameRoom.load_room(session)
  action = params[:action]

  if room
    next_room = room.go(action) || room.go('*')

    Map::GameRoom.save_room(session, next_room) if next_room

    redirect to('/game')
  else
    erb :you_died
  end
end

get '/bar' do
  <<-ENDRESPONSE
    Ruby:    #{RUBY_VERSION}
    Rack:    #{Rack::VERSION}
    Sinatra: #{Sinatra::VERSION}
    #{session['m'].inspect}
  ENDRESPONSE
end

get '/hero_room' do
  session[:room] = 'HERO_ROOM'

end
