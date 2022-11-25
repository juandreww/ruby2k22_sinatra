# frozen_string_literal: true

require './bin/rubyorg/map'
require './bin/hero_room'
require './bin/locked_door'
require 'test/unit'
require 'rack/test'
require 'byebug'

# Testing Game Room
class TestInitializeRoomAndDescription < Test::Unit::TestCase
  def test_room
    gold = Map::GameRoom.new('Gold Room', 'This room has gold in it, you can grab.\nThere\'s a door to the north.')
    assert_equal('Gold Room', gold.name)
    assert_equal({}, gold.paths)
  end

  def test_room_paths
    center = Map::GameRoom.new('Center', 'Test room in the center.')
    north = Map::GameRoom.new('North', 'Test room in the north')
    south = Map::GameRoom.new('South', 'Test room in the south.')

    center.add_paths({ 'north' => north, 'south' => south })
    assert_equal(north, center.go('north'))
    assert_equal(south, center.go('south'))
  end

  def test_map
    start = Map::GameRoom.new('Start', 'You can go west and down a hole.')
    west = Map::GameRoom.new('Trees', 'There are trees here,you can go east.')
    down = Map::GameRoom.new('Dungeon', 'It is dark down here, you can go up.')

    start.add_paths({ 'west' => west, 'down' => down })
    west.add_paths({ 'east' => start })
    down.add_paths({ 'up' => start })

    assert_equal(west, start.go('west'))
    assert_equal(start, start.go('west').go('east'))
    assert_equal(start, start.go('down').go('up'))
  end

  def test_gothon_game_map
    assert_equal(Map::GameRoom::GENERIC_DEATH, Map::GameRoom::START.go('shoot!'))
    assert_equal(Map::GameRoom::GENERIC_DEATH, Map::GameRoom::START.go('dodge!'))

    room = Map::GameRoom::START.go('tell a joke')
    assert_equal(Map::GameRoom::LASER_WEAPON_ARMORY, room)
  end

  def test_session_loading
    session = {}

    room = Map::GameRoom.load_room(session)
    assert_equal(room, nil)

    Map::GameRoom.save_room(session, Map::GameRoom::START)
    room = Map::GameRoom.load_room(session)
    assert_equal(room, Map::GameRoom::START)

    room = room.go('tell a joke')
    assert_equal(room, Map::GameRoom::LASER_WEAPON_ARMORY)

    Map::GameRoom.save_room(session, room)
    assert_equal(room, Map::GameRoom::LASER_WEAPON_ARMORY)
  end

  def test_spaceship
    HeroRoom.new.room
  end
end
