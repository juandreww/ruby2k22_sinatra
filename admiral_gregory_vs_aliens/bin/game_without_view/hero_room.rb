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
    @new_hero = Hero.new
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity
  def room
    puts 'He meets an Alien with type Ghoul. It barges in to Hero Room.
    Approaching slowly yet with intent to kill.'
    puts
    puts 'What the hero should do? (punch/ kick/ headbutt)'

    ghoul = @new_alien.ghoul
    damage = 0
    while ghoul.positive?
      next_move = false
      while next_move == false
        act = $stdin.gets.chomp
        next_move = true
        case act.downcase
        when 'punch' || 'p'
          damage = @new_hero.punch
        when 'kick' || 'k'
          damage = @new_hero.kick
        when 'headbutt' || 'h'
          damage = @new_hero.headbutt
        else
          puts 'Don\'t understand the command. Type again'
          next_move = false
        end
      end
      puts "Great! You went for a #{act.downcase} and deal damage of #{damage}"
      ghoul -= damage
      check_hero_next_action(ghoul)
    end
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity

  # rubocop:disable Metrics/MethodLength
  def check_input_act(act)
    next_move = true
    case act
    when '1'
      Armory.new.room
    when '2'
      CentralCorridor.new.room
    else
      puts 'Don\'t understand the command. Type again'
      next_move = false
    end

    next_move
  end
  # rubocop:enable Metrics/MethodLength

  # rubocop:disable Metrics/MethodLength
  def check_hero_next_action(ghoul)
    if ghoul.positive?
      puts "Ghoul's HP is now #{ghoul}"
      puts 'What the hero should do? (punch/ kick/ headbutt)'
    else
      puts 'Great. You killed Ghoul!'
      puts
      puts 'You have two option now. You can go to: (1. Laser Weapon Room / 2. Central Room)'
      next_move = false
      while next_move == false
        act = $stdin.gets.chomp
        next_move = check_input_act(act)
      end
    end
  end
  # rubocop:enable Metrics/MethodLength
end
