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

    assert_select ".characteristics" do |dl|
      assert_select dl, "button", "roll"
    end
  end
end