# frozen_string_literal: true

require 'sinatra'
require 'base64'
require './bin/rubyorg/map'
require './bin/hero_room'
require './bin/armory'
require './bin/central_corridor'

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
    erb :show_room, locals: { room: room }
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
  room = HeroRoom.new
  session[:ghoul] = room.ghoul
  session[:hero_next_move] = false
  path = '/hero_room'
  go_to_room(room, path)
end

post '/hero_room' do
  path = '/hero_room'
  room = HeroRoom.new
  action = params[:action].downcase
  damage, session[:hero_next_move], comment = room.damage_dealt_by_action(action)

  if session[:hero_next_move] == true
    session[:ghoul], comment = room.check_hero_next_action(session[:ghoul], damage)

    unless session[:ghoul].positive?
      session[:hero_next_move] = false
      path = '/path_after_hero_room'
    end
  end

  go_to_room(room, path, comment)
end

post '/path_after_hero_room' do
  action = params[:action].downcase
  case action
  when '1'
    redirect to('/armory')
  when '2'
    redirect to('/central_corridor')
  else
    comment = "Don't understand the command. Type again

  You have two option now. You can go to: (1. Laser Weapon Room / 2. Central Room)"

    path = '/hero_room'
    room = HeroRoom.new
    return go_to_room(room, path, comment)
  end

  go_to_room(room, path)
end

get '/armory' do
  session[:allow_using_weapon] = true
  redirect to('/central_corridor')
end

get '/central_corridor' do
  room = CentralCorridor.new
  session[:ghoul] = room.banshee
  comment = Armory.new.description + room.description
  path = '/central_corridor'
  go_to_room(room, path, comment)
end

post '/central_corridor' do
  path = '/central_corridor'
  room = CentralCorridor.new
  action = params[:action].downcase

  damage, session[:hero_next_move], comment = room.damage_dealt_by_action(action)
  if session[:hero_next_move] == true
    session[:banshee], comment = room.check_hero_next_action(session[:banshee], damage)

    unless session[:banshee].positive?
      session[:hero_next_move] = false
      path = '/path_after_central_corridor'
      comment += LockedDoor.new.description
    end
  end

  go_to_room(room, path, comment)
end

post '/path_after_central_corridor' do
  action = params[:action].downcase
  case action
  when '1'
    redirect to('/armory')
  when '2'
    redirect to('/central_corridor')
  else
    comment = "Don't understand the command. Type again

  You have two option now. You can go to: (1. Laser Weapon Room / 2. Central Room)"

    path = '/hero_room'
    room = HeroRoom.new
    return go_to_room(room, path, comment)
  end

  go_to_room(room, path)
end

def go_to_room(room, path, comment = nil)
  if room
    erb :show_room, locals: { room: room, path: path, comment: comment }
  else
    erb :you_died
  end
end
