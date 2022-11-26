# frozen_string_literal: true

require_relative 'game_engine'

# exit_room
class ExitRoom < Spaceship
  def initialize
    super

    @game_engine = GameEngine.new
  end

  # rubocop:disable Metrics/MethodLength
  def room
    @game_engine.loading_slow
    puts 'You are tired, yet the aliens are retreating far - far away.'
    puts 'You walk past the bridge and found the Escape Pod.'
    puts 'Now you are able to go back to Earth with peace'
    puts 'Happy ending!'
    @game_engine.loading_slow
    puts 'Play again? (yes/ no)'
    act = $stdin.gets.chomp
    case act.downcase
    when 'yes'
      puts 'Ok'
      @game_engine.in_game
    else
      puts 'Have a nice day'
      exit
    end
  end
  # rubocop:enable Metrics/MethodLength
end
