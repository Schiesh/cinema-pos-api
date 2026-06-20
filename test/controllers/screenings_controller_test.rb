require "test_helper"

class ScreeningsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get screenings_index_url
    assert_response :success
  end

  test "should get show" do
    get screenings_show_url
    assert_response :success
  end

  test "should get create" do
    get screenings_create_url
    assert_response :success
  end

  test "should get update" do
    get screenings_update_url
    assert_response :success
  end

  test "should get destroy" do
    get screenings_destroy_url
    assert_response :success
  end
end
