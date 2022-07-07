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
end
