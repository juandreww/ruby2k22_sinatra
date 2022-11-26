# frozen_string_literal: true

require_relative 'hero'
require_relative 'alien'
require_relative 'locked_door'

# central corridor
class CentralCorridor < Spaceship
  def initialize
    super()

    @new_hero = Hero.new
    @new_alien = Alien.new
    @banshee = @new_alien.banshee
    @name = 'Central Corridor'
    @description = "
  He meets an Alien with type Banshee. Due to its stealthy move, you cannot use Kick and Headbutt.
  Approaching slowly yet with intent to kill.

  What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)"
  end

  attr_reader :description, :name, :banshee

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize
  def damage_dealt_by_action(action)
    hero_next_move = true
    damage = 0

    case action
    when 'punch'
      damage = @new_hero.punch
    when 'kick'
      damage = -25
    when 'headbutt'
      damage = -25
    when 'excalibur'
      damage = @new_hero.excalibur_attack
    when 'muramasa'
      damage = @new_hero.muramasa_rifle_shot
    else
      hero_next_move = false
    end

    comment = if hero_next_move == true && (act.downcase == 'kick' || act.downcase == 'headbutt')
                "Oh no! You went for a #{action} and deal 0 damage. It increases HP of Banshee by #{damage.abs}"
              elsif hero_next_move == true
                "Great! You went for a #{action} and deal damage of #{damage}"
              else
                "Don't understand the command. Type again

  What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)"
              end

    [damage, hero_next_move, comment]
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize

  def check_hero_next_action(banshee, damage)
    banshee -= damage
    comment = if banshee.positive?
                "Banshee's HP is now #{banshee}

    What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)"
              else
                'Great. You killed Banshee!'
              end

    [banshee, comment]
  end
end
