require "test_helper"
require "minitest/mock"

class DicePoolTest < ActiveSupport::TestCase
  test "is empty by default" do
    pool = DicePool.new
    assert_equal [], pool.dice
  end

  test "can add dice to the pool" do
    pool = DicePool.new
    pool.add(Die.new)
    pool.add(Die.new)

    assert_equal 2, pool.dice.size
  end
end