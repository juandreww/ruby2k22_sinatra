require_relative './Alien'
require_relative './Hero'

class Spaceship
  def initialize
    @new_alien = Alien.new
    @new_hero = Hero.new
    @game_engine = GameEngine.new
  end

  def central_corridor
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
          puts 'You have no excalibur' if @new_hero.allow_weapon == false
        when 'muramasa'
          damage = @new_hero.muramasa_rifle_shot
          puts 'You have no muramasa' if @new_hero.allow_weapon == false
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
        puts "Great. You killed Banshee!"
        puts
        locked_door
      end
    end
  end

  def locked_door
    puts 'You are slowly walking to the bridge, when you meet a door with a digital lock in it'
    loading_slow
    puts 'You have to answer correctly the question. Or you will not be able to proceed to the next game.'
    puts 'What is the color that dont care?'
    try_count = 4
    while try_count.positive?
      act = $stdin.gets.chomp
      if act.downcase == 'biru donker'
        puts "Nice try. The color that dont care is 'Biru Donker!'"
        loading_slow
        puts "The door is opening.. Here your last enemy is standing"
        puts
        bridge
      else
        try_count -= 1
        puts "You are wrong. #{try_count} try left"
      end
    end
    puts "You are not able to answer correctly.. The aliens troops are approaching faster than anticipated"
    puts "You are hit with absolute damage and cruelty and your HP went to zero."
    @game_engine.game_over
  end

  def hero_room
    puts "He meets an Alien with type Ghoul. It barges in to Hero Room.
    Approaching slowly yet with it intent to kill."
    puts
    puts "What the hero should do? (punch/ kick/ headbutt)"

    ghoul = @new_alien.ghoul
    damage = 0
    while ghoul.positive?
      next_move = false
      while next_move == false
        act = $stdin.gets.chomp
        next_move = true
        case act.downcase
        when 'punch'
          damage = @new_hero.punch
        when 'kick'
          damage = @new_hero.kick
        when 'headbutt'
          damage = @new_hero.headbutt
        else
          puts 'Don\'t understand the command. Type again'
          next_move = false
        end
      end
      puts "Great! You went for a #{act.downcase} and deal damage of #{damage}"
      ghoul -= damage
      if ghoul.positive?
        puts "Ghoul's HP is now #{ghoul}"
        puts "What the hero should do? (punch/ kick/ headbutt)"
      else
        puts "Great. You killed Ghoul!"
        puts
        puts 'You have two option now. You can go to: (1. Laser Weapon Room / 2. Central Room)'
        next_move = false
        while next_move == false
          act = $stdin.gets.chomp
          next_move = true
          case act
          when '1'
            armory
          when '2'
            central_corridor
          else
            puts 'Don\'t understand the command. Type again'
            next_move = false
          end
        end
      end
    end
  end

  def armory
    loading
    puts "Right now you are #{@new_hero.allow_weapon ? 'allowed' : 'not allowed'} to hold these weapon.
    The Gods of War will grant you an excalibur and muramasa rifle."
    puts
    @new_hero.allow_weapon = true
    puts "Status is #{@new_hero.allow_weapon ? 'allowed' : 'not allowed'}"
    loading
    puts
    puts 'You are going to enter the central corridor with confidence'
    puts
    central_corridor
  end

  def bridge
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
          if previous_move == act
            damage = -100
          else
            damage = @new_hero.punch
          end
        when 'kick'
          if previous_move == act
            damage = -100
          else
            damage = @new_hero.kick
          end
        when 'headbutt'
          if previous_move == act
            damage = -100
          else
            damage = @new_hero.headbutt
          end
        when 'excalibur'
          if previous_move == act
            damage = -100
          else
            damage = @new_hero.excalibur_attack
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
        puts "Great. You killed Necromancer!"
        puts
        exit_room
      end
    end
  end

  def exit_room
    loading_slow
    puts 'You are tired, yet the aliens are retreating far - far away.'
    puts 'You walk past the bridge and found the Escape Pod.'
    puts 'Now you are able to go back to Earth with peace'
    puts 'Happy ending!'
    loading_slow
    puts 'Play again? (yes/ no)'
    act = $stdin.gets.chomp
    case act.downcase
    when 'yes'
      puts 'Ok'
      @game = GameEngine.new
      @game.in_game
    else
      puts 'Have a nice day'
      exit
    end
  end

  def loading
    5.times do
      puts '.'
      sleep(0.1)
    end
  end

  def loading_slow
    5.times do
      puts '.'
      sleep(0.5)
    end
  end
end
