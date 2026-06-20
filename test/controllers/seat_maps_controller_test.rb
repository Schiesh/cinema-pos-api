require "test_helper"

class SeatMapsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get seat_maps_show_url
    assert_response :success
  end

  test "should get create" do
    get seat_maps_create_url
    assert_response :success
  end

  test "should get update" do
    get seat_maps_update_url
    assert_response :success
  end
end
