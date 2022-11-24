# frozen_string_literal: true

require './bin/rubyorg/game_room'
require 'test/unit'
require 'rack/test'

# Testing Game Room
class TestInitializeRoomAndDescription < Test::Unit::TestCase
  def test_room
    gold = GameRoom.new('Gold Room', 'This room has gold in it, you can grab.\nThere\'s a door to the north.')
    assert_equal('Gold Room', gold.name)
  end

  def test_room_paths
    center = GameRoom.new('Center', 'Test room in the center.')
    north = GameRoom.new('North', 'Test room in the north')
    south = GameRoom.new('South', 'Test room in the south.')

    center.add_paths({ 'north' => north, 'south' => south })
    assert_equal(north, center.go('north'))
    assert_equal(south, center.go('south'))
  end

  def test_map
    start = GameRoom.new('Start', 'You can go west and down a hole.')
    west = GameRoom.new('Trees', 'There are trees here,you can go east.')
    down = GameRoom.new('Dungeon', 'It is dark down here, you can go up.')

    start.add_paths({ 'west' => west, 'down' => down })
    west.add_paths({ 'east' => start })
    down.add_paths({ 'up' => start })

    assert_equal(west, start.go('west'))
    assert_equal(start, start.go('west').go('east'))
    assert_equal(start, start.go('down').go('up'))
  end
end
