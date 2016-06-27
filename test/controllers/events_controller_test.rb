require 'test_helper'

class EventsControllerTest < ActionController::TestCase

  def setup
    @user = users(:user_fix_1)
    @other_user = users(:user_fix_2)
    @event = events(:event_fix_1)
  end
 
   test "should redirect new when not logged in" do
    get :new
    assert_redirected_to login_url
  end

  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

   test "should redirect create when not logged in" do
    start_at = Time.zone.now
    post :create, event: { event_name: 'test', space_entries_attributes: [start_time: start_at, end_time: start_at+ 60.minutes, space_id: @event.venue_user.venue.spaces.first.id] }
    assert_redirected_to login_url
  end

  test "should create event" do
    log_in_as(@user)
    start_at = Time.zone.now
    assert_difference(["Event.count", "SpaceEntry.count"], +1) do
      post :create, event: { event_name: 'test', space_entries_attributes: [start_time: start_at, end_time: start_at+ 60.minutes, space_id: @event.venue_user.venue.spaces.first.id] }
    end
  #   assert_redirected_to schedule_day_path( start_at.to_i )
   end

   test "should redirect destroy when not logged in" do
    delete :destroy, id: @event
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@other_user)
    delete :destroy, id: @event
    assert_redirected_to root_url
  end


  test "should destroy event" do
    log_in_as(@user)
    start_at = @event.space_entries.first.start_time
    assert_difference(["Event.count", "SpaceEntry.count"], -1) do
      delete :destroy, id: @event, schedule_id: 'day'
    end
    assert_redirected_to schedule_path('day', start_at.to_i )
  end

end
