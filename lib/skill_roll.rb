
class SkillRoll
  def initialize(dice_roller)
    @dice_roller = dice_roller
  end

  def skill_roll(level)
    roll = @dice_roller.roll(100)

    determine_result(level, roll)
  end

  def bonus_skill_roll(level, bonus: 0)
    roll = @dice_roller.roll(100)

    bonus_rolls = bonus.times.map { replace_tenth_for_roll(roll, @dice_roller.roll(10)) }
    roll = find_best_roll(roll, bonus_rolls)

    determine_result(level, roll)
  end

  def penalty_skill_roll(level, penalty: 0)
    roll = @dice_roller.roll(100)

    penalty_rolls = penalty.times.map { replace_tenth_for_roll(roll, @dice_roller.roll(10)) }
    roll = find_worst_roll(roll, penalty_rolls)

    determine_result(level, roll)
  end

  private

  def replace_tenth_for_roll(regular_roll, d10_roll)
    d10_roll * 10 + regular_roll % 10
  end

  def find_best_roll(roll, bonus_rolls)
    (bonus_rolls << roll).min
  end

  def find_worst_roll(roll, penalty_rolls)
    (penalty_rolls << roll).max
  end

  def determine_result(level, roll)
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
end



