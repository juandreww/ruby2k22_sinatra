# frozen_string_literal: true

# https://learnrubythehardway.org/book/ex47.html
class GameRoom
  def initialize(name, description)
    @name = name
    @description = description
    @paths = {}
  end

  # these make it easy for you to access the variables
  attr_reader :name, :paths, :description

  def go(direction)
    @paths[direction]
  end

  def add_paths(paths)
    @paths.update(paths)
  end
end
