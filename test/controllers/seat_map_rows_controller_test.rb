require "test_helper"

class SeatMapRowsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get seat_map_rows_create_url
    assert_response :success
  end

  test "should get update" do
    get seat_map_rows_update_url
    assert_response :success
  end

  test "should get destroy" do
    get seat_map_rows_destroy_url
    assert_response :success
  end
end
