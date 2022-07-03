
def skill_test(level, dice_roller)
  roll = dice_roller.roll(100)

  if roll == 1
    :critical_success
  elsif roll <= level / 5
    :extreme_success
  elsif roll <= level / 2
    :difficult_success
  elsif roll <= level
    :success
  else
    :failure
  end
end