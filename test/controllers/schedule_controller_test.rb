require 'test_helper'

class ScheduleControllerTest < ActionController::TestCase


  setup do
    @venue_user = venue_users(:venue_user_fix_2)
    @user = @venue_user.user
  end

  test "should redirect show when not logged in" do
    get :show
    assert_redirected_to login_url
  end

  test "should get show" do
    log_in_as(@user)
    get :show, id: 'day'
    assert_response :success
  end

end
