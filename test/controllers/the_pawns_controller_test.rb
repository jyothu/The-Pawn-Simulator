require "test_helper"

class ThePawnsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get the_pawns_index_url
    assert_response :success
  end

  test "should get move" do
    get the_pawns_move_url
    assert_response :success
  end
end
