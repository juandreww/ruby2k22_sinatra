# frozen_string_literal: true

require_relative 'game_engine'
require_relative 'bridge'

# locked door
class LockedDoor < Spaceship
  def initialize
    super

    @game_engine = GameEngine.new
    @name = 'Locked Door'
    @description = "You are slowly walking to the bridge, when you meet a door with a digital lock in it

  You have to answer correctly the question. Or you will not be able to proceed to the next game.
  What is the color that dont care?"
  end

  attr_reader :description, :name

  # rubocop:disable Metrics/MethodLength
  def room
    @game_engine.loading_slow
    try_count = 4
    while try_count.positive?
      act = $stdin.gets.chomp
      if act.downcase == 'biru donker'
        puts "Nice try. The color that dont care is 'Biru Donker!'"
        @game_engine.loading_slow
        puts 'The door is opening.. Here your last enemy is standing'
        puts
        Bridge.new.room
      else
        try_count -= 1
        puts "You are wrong. #{try_count} try left"
      end
    end
    puts 'You are not able to answer correctly.. The aliens troops are approaching faster than anticipated'
    puts 'You are hit with absolute damage and cruelty and your HP went to zero.'

    @game_engine.game_over
  end
  # rubocop:enable Metrics/MethodLength
end
