# frozen_string_literal: true

# armory
class Armory < Spaceship
  # rubocop:disable Metrics/MethodLength
  def armory
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
