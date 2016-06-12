require 'test_helper'

class SpaceTest < ActiveSupport::TestCase

  def setup
    @space = spaces(:space_fix_1)
  end


  test "should be valid" do
    assert @space.valid?
  end

  test "name should be present" do
    @space.name = ""
    assert_not @space.valid?
  end

  test "name should not be too long" do
    @space.name = "a" * 51
    assert_not @space.valid?
  end

 test "should require a user_id" do
    @space.venue_id = nil
    assert_not @space.valid?
  end

end
