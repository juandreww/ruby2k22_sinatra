# frozen_string_literal: true

require_relative './Alien'
require_relative './Hero'

# Spaceship
class Spaceship
  def initialize
    @new_alien = Alien.new
    @new_hero = Hero.new
    @game_engine = GameEngine.new
  end
end
