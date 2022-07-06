
class SkillRoll
  def initialize(dice_roller)
    @dice_roller = dice_roller
  end

  def skill_roll(level, bonus: 0)
    roll = @dice_roller.roll(100)

    bonus_rolls = bonus.times.collect { calculate_roll_with_bonus(roll, @dice_roller.roll(10)) }
    roll = find_best_roll(roll, bonus_rolls)

    determine_result(level, roll)
  end

  private

  def calculate_roll_with_bonus(regular_roll, bonus_roll)
    bonus_roll * 10 + regular_roll % 10
  end

  def find_best_roll(roll, bonus_rolls)
    (bonus_rolls << roll).min
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



