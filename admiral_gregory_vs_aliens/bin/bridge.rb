# frozen_string_literal: true

require_relative 'exit_room'

# Bridge
class Bridge < Spaceship
  # rubocop:disable Metrics/MethodLength
  def initialize
    super

    @new_alien = Alien.new
    @necromancer = @new_alien.necromancer
    @new_hero = Hero.new
    @new_hero.allow_weapon = true
    @name = 'Bridge'
    @description = "Nice try. The color that dont care is 'Biru Donker!'

  The door is opening.. Here your last enemy is standing
  .
  .
  .
  .
  .


  He meets an Alien with type Necromancer. Due to its intelligence, you cannot use the same move repeatedly.
  Approaching slowly yet with intent to kill.

  necromancer's HP is now #{@necromancer}
  What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)"
  end
  # rubocop:enable Metrics/MethodLength

  attr_reader :description, :name, :necromancer

  # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize
  def damage_dealt_by_action(action, previous_move, allow_using_weapon)
    hero_next_move = true
    damage = 0

    case action
    when 'punch'
      damage = @new_hero.punch
    when 'kick'
      damage = @new_hero.kick
    when 'headbutt'
      damage = @new_hero.headbutt
    when 'excalibur'
      damage = allow_using_weapon ? @new_hero.excalibur_attack : 0
    when 'muramasa'
      damage = allow_using_weapon ? @new_hero.muramasa_rifle_shot : 0
    else
      hero_next_move = false
    end

    if previous_move == action
      damage = -100
      hero_next_move = false
      comment = "Oh no! You went for a #{action} and Necromancer saw it coming.
    It increases HP of Necromancer by #{damage.abs}"
    elsif hero_next_move == true
      comment = "Great! You went for a #{action} and deal damage of #{damage}"
    end

    [damage, hero_next_move, comment]
  end
  # rubocop:enable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/AbcSize

  def check_hero_next_action(necromancer, damage)
    necromancer -= damage

    comment = if necromancer.positive?
                "Necromancer's HP is now #{necromancer}

  What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)"
              else
                ''
              end

    [necromancer, comment]
  end
end
