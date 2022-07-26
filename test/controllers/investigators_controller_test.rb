class InvestigatorsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @hoff = investigators(:hoff)
  end

  test "index lists all investigators along with links to individuals" do
    get investigators_url

    assert_response :success
    assert_match "Hoff Dickens", @response.body
    assert_match "Clara Lovelace", @response.body

    assert_match investigator_path(@hoff), @response.body
    assert_no_match "STR", @response.body
  end

  test "show shows the details of one investigator" do
    get investigator_url(@hoff)

    assert_response :success
    assert_match "Hoff Dickens", @response.body
    assert_match "STR", @response.body

    assert_no_match "Clara", @response.body
  end

  test "it shows a skill roll button per characteristic" do
    get investigator_url(@hoff)

    assert_select "form" do |el|
      assert_select el, "button", "roll"
    end
  end

  test "it rolls a skill roll for a given skill" do
    post skill_roll_url(@hoff, :str)

    assert_response :success
  end

  test "it raises an error if trying to roll for a non-skill" do
    post skill_roll_url(@hoff, :to_s)
    assert_response 400

    post skill_roll_url(@hoff, :does_not_exist)
    assert_response 400
  end
end