
def skill_roll(level, dice_roller)
  roll = dice_roller.roll(100)

  result = if roll == 1
    :critical_success
  elsif roll <= level / 5
    :extreme_success
  elsif roll <= level / 2
    :hard_success
  elsif roll <= level
    :success
  elsif roll == 100
    :fumble
  elsif roll >= 96 && level < 50
    :fumble
  else
    :failure
  end

  { rolled: roll, result: result }
end