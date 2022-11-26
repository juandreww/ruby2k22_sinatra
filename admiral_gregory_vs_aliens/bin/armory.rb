# frozen_string_literal: true

require_relative 'game_engine'
require_relative 'hero'
require_relative 'central_corridor'

# armory
class Armory < Spaceship
  # rubocop:disable Metrics/MethodLength
  def initialize
    super

    @game_engine = GameEngine.new
    @name = 'Armory'
    @description = "Right now you are not allowed to hold sacred weapon.
  The Gods of War grant you an excalibur and muramasa rifle.

  Status is: Allowed to hold weapon

  From the Laser Weapon Room, You are now going to enter the Central Corridor with Confidence

  .
  .
  .
  .
  .
  \n\n"
  end
  # rubocop:enable Metrics/MethodLength

  attr_reader :description, :name
end
