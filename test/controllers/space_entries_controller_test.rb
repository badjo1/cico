require 'test_helper'

class SpaceEntriesControllerTest < ActionController::TestCase

  setup do
    @venue_user = venue_users(:venue_user_fix_2)
    @user = @venue_user.user
    
    @space_entry = space_entries(:space_entry_fix_1)
  end
 
 test "should get edit" do
    log_in_as(@user)
    get :edit, id: @space_entry
    assert_response :success
  end

  test "should get update" do
  end

end
