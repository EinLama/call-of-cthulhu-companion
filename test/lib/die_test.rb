require "test_helper"
require "minitest/mock"

class DieTest < ActiveSupport::TestCase
  test "can instantiate with eyes" do
    [4, 6, 8, 12, 20, 100].each do |eye_count|
      die = Die.new(eye_count)
      assert_equal eye_count, die.eyes
    end
  end

  test "will be a d100 by default" do
    d100 = Die.new
    assert_equal 100, d100.eyes
  end

  test "can be rolled" do
    die = Die.new

    die.stubs(:random_generator).with(1..100).returns(42)

    rolled = die.roll!
    assert_equal 42, rolled
  end

  test "rolled eyes affected by eyes" do
    die = Die.new(8)

    die.stubs(:random_generator).with(1..8).returns(2)

    rolled = die.roll!
    assert_equal 2, rolled
  end
end