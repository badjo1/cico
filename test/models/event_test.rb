require 'test_helper'

class EventTest < ActiveSupport::TestCase

  def setup
    @event = events(:event_fix_1)
  end

  test "should be valid" do
    assert @event.valid?
  end

 test "event name should be present" do
    @event.event_name = ""
    assert_not @event.valid?
  end

  test "event name should not be too long" do
    @event.event_name = "a" * 256
    assert_not @event.valid?
  end

  test "should require a venue_user_id" do
    @event.venue_user_id = nil
    assert_not @event.valid?
  end


end
