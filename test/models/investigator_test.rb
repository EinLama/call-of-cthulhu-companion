require "test_helper"

class InvestigatorTest < ActiveSupport::TestCase
  def setup
    @hoff = investigators(:hoff)
    @clara = investigators(:clara)
  end

  test "has maximum HP calculated" do
    assert_equal(10, @hoff.max_hp)
  end

  test "max HP calculation is using floor to round" do
    # Before rounding, Clara has 8.6 HP max:
    assert_equal(8, @clara.max_hp)
  end

  test "returns characteristics" do
    characteristics = @hoff.characteristics

    expected_characteristics = %i[
      str con dex int
      siz pow app edu
    ]

    assert_equal expected_characteristics, characteristics
  end

  test "returns the hard value for a characteristic" do
    assert_equal 30, @hoff.hard_value(:str)
    assert_equal 19, @clara.hard_value(:con)
  end

  test "returns the extreme value for a characteristic" do
    assert_equal 12, @hoff.extreme_value(:str)
    assert_equal 7, @clara.extreme_value(:con)
  end

  test "raises when passing a non-characteristic" do
    assert_raises { @hoff.hard_value(:no_characteristic) }
    assert_raises { @hoff.extreme_value(:no_characteristic) }
  end
end
