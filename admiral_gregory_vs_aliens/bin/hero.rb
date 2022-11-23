# frozen_string_literal: true

class Hero
  def initialize
    @allow_weapon = false
  end

  attr_accessor :allow_weapon

  def punch
    10
  end

  def kick
    20
  end

  def headbutt
    30
  end

  def excalibur_attack
    return 0 if @allow_weapon == false

    300
  end

  def muramasa_rifle_shot
    return 0 if @allow_weapon == false

    250
  end
end
