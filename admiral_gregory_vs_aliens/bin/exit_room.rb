# frozen_string_literal: true

# exit_room
class ExitRoom < Spaceship
  # rubocop:disable Metrics/MethodLength
  def initialize
    super

    @name = 'Exit Room'
    @description = "Great. You killed Necromancer!

  .
  .
  .
  .
  .


  You are tired, yet the aliens are retreating far - far away.
  You walk past the bridge and found the Escape Pod.
  Now you are able to go back to Earth with peace

  Happy ending!
  .
  .
  .
  .
  .


  Play again? (yes/ no)
  "
  end
  # rubocop:enable Metrics/MethodLength

  attr_reader :description, :name
end
