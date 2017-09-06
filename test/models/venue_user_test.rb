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

  test "venue and user should be unique" do
    duplicate_venue_user = @venue_user.dup
    duplicate_venue_user.save
    assert_not duplicate_venue_user.valid?
  end

  test "order should be most recent" do
    most_recent = VenueUser.find_most_recent_by(@venue_user.user_id)
    assert_not_equal venue_users(:venue_user_latest), most_recent
  end

  test "assign admin role should be admin" do
    @venue_user.assign_admin_role
    assert_equal @venue_user.role, VenueUser::ADMIN_ROLE_NAME
    assert @venue_user.admin?
  end


end
