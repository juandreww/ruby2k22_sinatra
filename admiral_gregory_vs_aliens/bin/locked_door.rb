# frozen_string_literal: true

require_relative 'bridge'

# locked door
class LockedDoor < Spaceship
  # rubocop:disable Metrics/MethodLength
  def initialize
    super

    @name = 'Locked Door'
    @description = "Great. You killed Banshee!

  .
  .
  .
  .
  .


  You are slowly walking to the bridge, when you meet a door with a digital lock in it

  You have to answer correctly the question. Or you will not be able to proceed to the next game.

  What is the color that dont care?"
  end
  # rubocop:enable Metrics/MethodLength

  attr_reader :description, :name

  # rubocop:disable Metrics/MethodLength
  def check_hero_next_action(try_count, action)
    hero_next_move = false
    comment = nil
    if action == 'biru donker'
      hero_next_move = true
    else
      try_count -= 1
      comment = "You are wrong. #{try_count} try left\n"
      if try_count.zero?
        comment += "You are not able to answer correctly.. The aliens troops are approaching faster than anticipated

  You are hit with absolute damage and cruelty and your HP went to zero."
      end
    end

    [try_count, hero_next_move, comment]
  end
  # rubocop:enable Metrics/MethodLength
end
