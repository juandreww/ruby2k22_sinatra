# frozen_string_literal: true

require_relative 'hero'
require_relative 'alien'
require_relative 'locked_door'

# central corridor
class CentralCorridor < Spaceship
  def initialize
    super

    @new_hero = Hero.new
    @new_alien = Alien.new
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
  def room
    puts "He meets an Alien with type Banshee. Due to its stealthy move, you cannot use Kick and Headbutt.
    Approaching slowly yet with it intent to kill."
    puts
    puts 'What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)'

    banshee = @new_alien.banshee
    damage = 0
    while banshee.positive?
      next_move = false
      while next_move == false
        act = $stdin.gets.chomp
        next_move = true
        case act.downcase
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
          puts 'Don\'t understand the command. Type again'
          next_move = false
        end
      end

      if act.downcase == 'kick' || act.downcase == 'headbutt'
        puts "Oh no! You went for a #{act.downcase} and deal 0 damage. It increases HP of Banshee by #{damage.abs}"
      else
        puts "Great! You went for a #{act.downcase} and deal damage of #{damage}"
      end

      banshee -= damage
      if banshee.positive?
        puts "Banshee's HP is now #{banshee}"
        puts 'What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)'
      else
        puts 'Great. You killed Banshee!'
        puts
        LockedDoor.new.room
      end
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/AbcSize, Metrics/MethodLength, Metrics/PerceivedComplexity
end
