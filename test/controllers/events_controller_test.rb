require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  def setup
    @venue_user = venue_users(:venue_user_fix_2)
    @user = @venue_user.user
    @other_user = users(:user_fix_1)
  end
 
  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should create event" do
    log_in_as(@user)
    start_at = Time.zone.now
    assert_difference('Event.count') do
      post :create, event: { event_name: 'test', space_entries_attributes: [start_time: start_at, end_time: start_at+ 60.minutes, space_id: @venue_user.venue.spaces.first.id] }
    end
    assert_redirected_to book_path( start_at.to_i )
  end

end
