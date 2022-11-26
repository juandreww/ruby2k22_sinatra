# frozen_string_literal: true

require_relative 'exit_room'

# Bridge
class Bridge < Spaceship
  def initialize
    super

    @new_alien = Alien.new
    @new_hero = Hero.new
    @new_hero.allow_weapon = true
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
  def room
    puts "He meets an Alien with type Necromancer. Due to its intelligence, you cannot use the same move repeatedly.
    Approaching slowly yet with intent to kill."
    puts

    necromancer = @new_alien.necromancer
    damage = 0
    previous_move = ''

    while necromancer.positive?
      puts "necromancer's HP is now #{necromancer}"
      puts 'What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)'
      next_move = false
      while next_move == false
        act = $stdin.gets.chomp
        next_move = true
        damage, next_move = damage_dealt_by_hero(act.downcase, previous_move, next_move)
      end

      if act == previous_move
        puts "Oh no! You went for a #{act.downcase} and Necromancer saw it coming.
        It increases HP of Necromancer by #{damage.abs}"
      else
        puts "Great! You went for a #{act.downcase} and deal damage of #{damage}"
      end

      necromancer -= damage
      previous_move = act
    end

    puts 'Great. You killed Necromancer!'
    puts

    ExitRoom.new.room
  end
  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def damage_dealt_by_hero(act, previous_move, next_move)
    return [-100, next_move] if act == previous_move

    damage = 0
    case act
    when 'punch' || 'p'
      damage = @new_hero.punch
    when 'kick' || 'k'
      damage = @new_hero.kick
    when 'headbutt' || 'h'
      damage = @new_hero.headbutt
    when 'excalibur' || 'e'
      damage = @new_hero.excalibur_attack
    when 'muramasa' || 'm'
      damage = @new_hero.muramasa_rifle_shot
    else
      puts 'Don\'t understand the command. Type again'
      next_move = false
    end

    [damage, next_move]
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end
