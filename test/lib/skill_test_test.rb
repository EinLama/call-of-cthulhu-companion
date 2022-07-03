require "test_helper"
require "minitest/mock"

class SkillTestTest < ActiveSupport::TestCase
  test "is a success if rolled number is below or equal skill level" do
    dice_roller = Object.new
    dice_roller.expects(:roll).with(100).returns(40)
    result = skill_test(50, dice_roller)
    assert result == :success

    dice_roller.expects(:roll).with(100).returns(50)
    result = skill_test(50, dice_roller)
    assert result == :success
  end

  test "is a failure is rolled number is above skill level" do
    dice_roller = Object.new
    dice_roller.expects(:roll).with(100).returns(51)

    result = skill_test(50, dice_roller)
    assert result == :failure
  end

  test "is a difficult success if rolled number is below or equal 1/2 of skill level" do
    dice_roller = Object.new
    dice_roller.expects(:roll).with(100).returns(25)

    result = skill_test(50, dice_roller)
    assert result == :difficult_success
  end

  test "is an extreme success if rolled number is below or equal 1/5 of skill level" do
    dice_roller = Object.new
    dice_roller.expects(:roll).with(100).returns(10)

    result = skill_test(50, dice_roller)
    assert result == :extreme_success
  end

  test "is an critical success if rolled number is 1" do
    dice_roller = Object.new
    dice_roller.expects(:roll).with(100).returns(1)

    result = skill_test(50, dice_roller)
    assert result == :critical_success
  end
end