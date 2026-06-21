require "test_helper"

class SiteSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get site_settings_show_url
    assert_response :success
  end

  test "should get update" do
    get site_settings_update_url
    assert_response :success
  end
end
