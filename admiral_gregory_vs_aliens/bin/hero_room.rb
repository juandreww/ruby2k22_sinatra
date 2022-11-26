# frozen_string_literal: true

require_relative 'spaceship'
require_relative 'alien'
require_relative 'hero'
require_relative 'armory'
require_relative 'central_corridor'

# HeroRoom
class HeroRoom < Spaceship
  def initialize
    super

    @new_alien = Alien.new
    @ghoul = @new_alien.ghoul
    @new_hero = Hero.new
    @description = "  He meets an Alien with type Ghoul. It barges in to Hero Room.
    Approaching slowly yet with intent to kill.

    What the hero should do? (punch/ kick/ headbutt)"
    @name = 'Hero Room'
  end

  attr_reader :description, :name, :ghoul

  # rubocop:disable Metrics/MethodLength
  def damage_dealt_by_action(action)
    hero_next_move = true
    damage = 0
    case action
    when 'punch'
      damage = @new_hero.punch
    when 'kick'
      damage = @new_hero.kick
    when 'headbutt'
      damage = @new_hero.headbutt
    else
      hero_next_move = false
    end

    comment = if hero_next_move == true
                "Great! You went for a #{action} and deal damage of #{damage}\n\n"
              else
                "Don't understand the command. Type again

  What the hero should do? (punch/ kick/ headbutt)"
              end

    [damage, hero_next_move, comment]
  end
  # rubocop:enable Metrics/MethodLength

  def check_hero_next_action(ghoul, damage)
    ghoul -= damage
    comment = if ghoul.positive?
                " Ghoul's HP is now #{ghoul}\n
  What the hero should do? (punch/ kick/ headbutt)"
              else
                "Great. You killed Ghoul!
  You have two option now.

  You can go to: (1. Laser Weapon Room / 2. Central Room)"
              end

    [ghoul, comment]
  end
end
