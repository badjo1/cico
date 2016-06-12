require 'test_helper'

class VenueUserTest < ActiveSupport::TestCase

  def setup
     @venue_user = venue_users(:venue_user_fix_1)
  end

  test "should be valid" do
    assert @venue_user.valid?
  end

  test "should require a venue_id" do
    @venue_user.venue_id = nil
    assert_not @venue_user.valid?
  end

  test "should require a user_id" do
    @venue_user.user_id = nil
    assert_not @venue_user.valid?
  end

   test "order should be most recent" do
    last_active = VenueUser.find_most_recent_by(@venue_user.user_id)
    assert_equal venue_users(:venue_user_fix_most_recent), last_active
    assert last_active.user.valid?
  end

end
