require "test_helper"
require "minitest/mock"

class SkillRollTest < ActiveSupport::TestCase
  def setup
    @dice_roller = mock()
  end

  test "is a success if rolled number is below skill level" do
    @dice_roller.expects(:roll).with(100).returns(40)

    skill_roll = SkillRoll.new(@dice_roller)
    result = skill_roll.skill_roll(50)

    expected = { result: :success, rolled: 40 }
    assert_equal expected, result
  end

  test "is a success if rolled number is equal to skill level" do
    @dice_roller.expects(:roll).with(100).returns(50)

    skill_roll = SkillRoll.new(@dice_roller)
    result = skill_roll.skill_roll(50)

    expected = { result: :success, rolled: 50 }
    assert_equal expected, result
  end

  test "is a failure is rolled number is above skill level" do
    @dice_roller.expects(:roll).with(100).returns(51)

    skill_roll = SkillRoll.new(@dice_roller)
    result = skill_roll.skill_roll(50)

    expected = { result: :failure, rolled: 51 }
    assert_equal expected, result
  end

  test "is a hard success if rolled number is below or equal 1/2 of skill level" do
    @dice_roller.expects(:roll).with(100).returns(25)

    skill_roll = SkillRoll.new(@dice_roller)
    result = skill_roll.skill_roll(50)

    expected = { result: :hard_success, rolled: 25 }
    assert_equal expected, result
  end

  test "is an extreme success if rolled number is below or equal 1/5 of skill level" do
    @dice_roller.expects(:roll).with(100).returns(10)

    skill_roll = SkillRoll.new(@dice_roller)
    result = skill_roll.skill_roll(50)

    expected = { result: :extreme_success, rolled: 10 }
    assert_equal expected, result
  end

  test "is an critical success if rolled number is 1" do
    @dice_roller.expects(:roll).with(100).returns(1)

    skill_roll = SkillRoll.new(@dice_roller)
    result = skill_roll.skill_roll(50)

    expected = { result: :critical_success, rolled: 1 }
    assert_equal expected, result
  end

  test "is a fumble if rolled 100 and skill is >= 50" do
    [50, 61, 77, 90].each do |skill_level|
      @dice_roller.expects(:roll).with(100).returns(100)

      skill_roll = SkillRoll.new(@dice_roller)
      result = skill_roll.skill_roll(skill_level)

      expected = { result: :fumble, rolled: 100 }
      assert_equal expected, result
    end
  end

  test "is a failure if rolled below 100 and skill is >= 50" do
    [61, 77, 90, 95, 99].each do |rolled_eyes|
      @dice_roller.expects(:roll).with(100).returns(rolled_eyes)

      skill_roll = SkillRoll.new(@dice_roller)
      result = skill_roll.skill_roll(50)

      expected = { result: :failure, rolled: rolled_eyes }
      assert_equal expected, result
    end
  end

  test "is a fumble if rolled >= 96 and skill is < 50" do
    [96, 97, 98, 99, 100].each do |rolled_eyes|
      @dice_roller.expects(:roll).with(100).returns(rolled_eyes)

      skill_roll = SkillRoll.new(@dice_roller)
      result = skill_roll.skill_roll(49)

      expected = { result: :fumble, rolled: rolled_eyes }
      assert_equal expected, result
    end
  end

  test "is a failure if rolled < 96 and skil is < 50" do
    [95, 90, 60].each do |rolled_eyes|
      @dice_roller.expects(:roll).with(100).returns(rolled_eyes)

      skill_roll = SkillRoll.new(@dice_roller)
      result = skill_roll.skill_roll(49)

      expected = { result: :failure, rolled: rolled_eyes }
      assert_equal expected, result
    end
  end
end