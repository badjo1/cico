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

  test "event type validation should accept valid event types" do
    Event::EVENT_TYPES.each do |valid_event_type|
      @event.event_type = valid_event_type
      assert @event.valid?, "#{valid_event_type.inspect} should be valid"
    end
  end

  test "event type  validation should reject invalid event types" do
    @event.event_type = "some crazy value"
    assert_not @event.valid?, "event type should be invalid"
  end


  test "should require a venue_user_id" do
    @event.venue_user_id = nil
    assert_not @event.valid?
  end

  test "should require a valid frequeny" do
    assert_equal @event.frequency.repeat, 'none'

    @event.frequency = Frequency.new('weekly')
    assert_equal @event.frequency.repeat, 'weekly'
  end



end
