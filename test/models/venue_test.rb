require 'test_helper'

class VenueTest < ActiveSupport::TestCase

  def setup
    @venue = venues(:venue_fix_1)
  end

  test "should be valid" do
    assert @venue.valid?
  end

 test "name should be present" do
    @venue.name = ""
    assert_not @venue.valid?
  end


  test "name should not be too long" do
    @venue.name = "a" * 51
    assert_not @venue.valid?
  end

end
