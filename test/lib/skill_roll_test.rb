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
end