require "test_helper"
require "minitest/mock"

class SkillRollTest < ActiveSupport::TestCase
  test "is a success if rolled number is below or equal skill level" do
    dice_roller = mock()
    dice_roller.expects(:roll).with(100).returns(40)
    result = skill_roll(50, dice_roller)
    assert_equal :success, result

    dice_roller.expects(:roll).with(100).returns(50)
    result = skill_roll(50, dice_roller)
    assert_equal :success, result
  end

  test "is a failure is rolled number is above skill level" do
    dice_roller = mock()
    dice_roller.expects(:roll).with(100).returns(51)

    result = skill_roll(50, dice_roller)
    assert_equal :failure, result
  end

  test "is a hard success if rolled number is below or equal 1/2 of skill level" do
    dice_roller = mock()
    dice_roller.expects(:roll).with(100).returns(25)

    result = skill_roll(50, dice_roller)
    assert_equal :hard_success, result
  end

  test "is an extreme success if rolled number is below or equal 1/5 of skill level" do
    dice_roller = mock()
    dice_roller.expects(:roll).with(100).returns(10)

    result = skill_roll(50, dice_roller)
    assert_equal :extreme_success, result
  end

  test "is an critical success if rolled number is 1" do
    dice_roller = mock()
    dice_roller.expects(:roll).with(100).returns(1)

    result = skill_roll(50, dice_roller)
    assert_equal :critical_success, result
  end

  test "is a fumble if rolled 100 and skill is >= 50" do
    dice_roller = mock()

    [50, 61, 77, 90].each do |skill_level|
      dice_roller.expects(:roll).with(100).returns(100)

      result = skill_roll(skill_level, dice_roller)
      assert_equal :fumble, result
    end
  end

  test "is a failure if rolled below 100 and skill is >= 50" do
    dice_roller = mock()

    [61, 77, 90, 95, 99].each do |rolled_eyes|
      dice_roller.expects(:roll).with(100).returns(rolled_eyes)

      result = skill_roll(50, dice_roller)
      assert_equal :failure, result
    end
  end

  test "is a fumble if rolled >= 96 and skill is < 50" do
    dice_roller = mock()

    [96, 97, 98, 99, 100].each do |rolled_eyes|
      dice_roller.expects(:roll).with(100).returns(rolled_eyes)

      result = skill_roll(49, dice_roller)
      assert_equal :fumble, result
    end
  end

  test "is a failure if rolled < 96 and skil is < 50" do
    dice_roller = mock()

    [95, 90, 60].each do |rolled_eyes|
      dice_roller.expects(:roll).with(100).returns(rolled_eyes)

      result = skill_roll(49, dice_roller)
      assert_equal :failure, result
    end
  end
end