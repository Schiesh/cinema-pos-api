require "test_helper"

class PlayWeeksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get play_weeks_index_url
    assert_response :success
  end

  test "should get show" do
    get play_weeks_show_url
    assert_response :success
  end

  test "should get create" do
    get play_weeks_create_url
    assert_response :success
  end

  test "should get update" do
    get play_weeks_update_url
    assert_response :success
  end

  test "should get destroy" do
    get play_weeks_destroy_url
    assert_response :success
  end
end
