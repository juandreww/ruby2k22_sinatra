# frozen_string_literal: true

# Bridge
class Bridge < Spaceship
  def room
    puts "He meets an Alien with type Necromancer. Due to its intelligence, you cannot use the same move repeatedly.
    Approaching slowly yet with it intent to kill."
    puts
    puts 'What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)'

    necromancer = @new_alien.necromancer
    damage = 0
    previous_move = ''
    while necromancer.positive?
      next_move = false
      while next_move == false
        act = $stdin.gets.chomp
        next_move = true
        case act.downcase
        when 'punch'
          damage = if previous_move == act
                    -100
                  else
                    @new_hero.punch
                  end
        when 'kick'
          damage = if previous_move == act
                      -100
                    else
                      @new_hero.kick
                    end
        when 'headbutt'
          damage = if previous_move == act
                    -100
                  else
                    @new_hero.headbutt
                  end
        when 'excalibur'
          damage = if previous_move == act
                    -100
                  else
                    @new_hero.excalibur_attack
                  end
          puts 'You have no excalibur' if @new_hero.allow_weapon == false
        when 'muramasa'
          if previous_move == act
            damage = -100
          else
            damage = @new_hero.muramasa_rifle_shot
          end
          puts 'You have no muramasa' if @new_hero.allow_weapon == false
        else
          puts 'Don\'t understand the command. Type again'
          next_move = false
        end
      end

      if act == previous_move
        puts "Oh no! You went for a #{act.downcase} and Necromancer saw it coming. It increases HP of Necromancer by #{damage.abs}"
      else
        puts "Great! You went for a #{act.downcase} and deal damage of #{damage}"
      end

      necromancer -= damage
      previous_move = act
      if necromancer.positive?
        puts "necromancer's HP is now #{necromancer}"
        puts 'What the hero should do? (punch/ kick/ headbutt/ excalibur/ muramasa)'
      else
        puts 'Great. You killed Necromancer!'
        puts
        exit_room
      end
    end
  end
end
