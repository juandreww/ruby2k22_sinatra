# frozen_string_literal: true

require_relative 'hero_room'

# Game Engine
class GameEngine
  def initialize
    @current_state = ''

    @hero_room = HeroRoom.new
  end

  def start
    gets = $stdin.gets.chomp
    if gets == 'start'
      @current_state = ''
      opening_text
      in_game
    end
    start
  end

  def opening_text
    puts "Aliens have invaded a space ship and our hero has to go through a maze of rooms defeating them
     so he can escape into an escape pod to the planet below.\n
    The game will be more like a Zork or Adventure type game with text outputs and funny ways to die.\n
    The game will involve an engine that runs a map full of rooms or scenes. Each room will print its own description
     when the player enters it and then tell the engine what room to run next out of the map."
  end

  def in_game
    puts
    opening_text
    @hero_room.room
  end

  def game_over
    puts 'Game Over.. Retry? (yes/ no)'
    act = $stdin.gets.chomp
    case act.downcaseprevious_move = 'punch'
    when 'yes'
      puts 'Ok'
      in_game
    else
      puts 'Sorry to see you go. Play again!'
    end
  end

  def loading
    5.times do
      puts '.'
      sleep(0.1)
    end
  end

  def loading_slow
    5.times do
      puts '.'
      sleep(0.5)
    end
  end
end
