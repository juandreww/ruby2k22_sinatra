# frozen_string_literal: true

require_relative 'game_engine'
require_relative 'central_corridor'

# armory
class Armory < Spaceship
  def initialize
    super

    @game_engine = GameEngine.new
  end

  # rubocop:disable Metrics/MethodLength
  def room
    @game_engine.loading
    puts "Right now you are #{@new_hero.allow_weapon ? 'allowed' : 'not allowed'} to hold these weapon.
    The Gods of War will grant you an excalibur and muramasa rifle."
    puts
    @new_hero.allow_weapon = true
    puts "Status is #{@new_hero.allow_weapon ? 'allowed' : 'not allowed'}"
    @game_engine.loading
    puts
    puts 'You are going to enter the central corridor with confidence'
    puts
    CentralCorridor.new.room
  end
  # rubocop:enable Metrics/MethodLength
end
