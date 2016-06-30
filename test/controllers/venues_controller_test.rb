require 'test_helper'

class VenuesControllerTest < ActionController::TestCase

   def setup
    @user = users(:user_fix_2)
    @venue = venues(:venue_fix_1)
  end

  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should redirect create when not logged in" do
    post :create, venue: { name: @venue.name}
    assert_redirected_to login_url
  end

  test "should create venue" do
    log_in_as(@user)
    assert_difference(["Venue.count", "VenueUser.count"],+1) do
      post :create, venue: { name: "@venue.name", subdomain: "unique"}
    end
    assert_redirected_to user_path(@user)
  end

end
