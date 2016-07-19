require 'test_helper'

class SpaceEntryTest < ActiveSupport::TestCase

  def setup
    @space_entry = space_entries(:space_entry_fix_1)
  end

  test "should be valid" do
    assert @space_entry.valid?
  end

  test "should require a event_id" do
    # TODO: make test work, but conflict with nested forms
    # @space_entry.event_id = nil
    # assert_not @space_entry.valid?
  end

  test "should require a space_id" do
    @space_entry.space_id = nil
    assert_not @space_entry.valid?
  end

  test "should require a start_time" do
    @space_entry.start_time = nil
    assert_not @space_entry.valid?
  end

  test "start_time validation should reject invalid time" do
    invalid_start_times = %w[aa 2-31-2009]
    invalid_start_times.each do |invalid_start_time|
      @space_entry.start_time = invalid_start_time
      assert_not @space_entry.valid?, "#{invalid_start_time.inspect} should be invalid"
    end
  end

  test "should require a end_time" do
    @space_entry.end_time = nil
    assert_not @space_entry.valid?
  end

  test "end_time should be after start_time" do
    @space_entry.end_time = @space_entry.start_time - 5.minutes
    assert_not @space_entry.valid?
  end

  test "end_time validation should reject if it is not on the same day" do
    @space_entry.end_time = @space_entry.start_time + 1.day
    assert_not @space_entry.valid?
  end

  test "Start time can not in another slot" do
    assert @space_entry.valid?

    dup_space_entry = @space_entry.dup
    assert_not dup_space_entry.valid?


    dup_space_entry.start_time += 2.minutes
    assert_not dup_space_entry.valid?

    dup_space_entry.start_time = @space_entry.end_time - 1.second
    assert_not dup_space_entry.valid?

    dup_space_entry.start_time = @space_entry.end_time
    dup_space_entry.end_time = @space_entry.end_time + 10.minutes
    assert dup_space_entry.valid?
  end

  test "duration in minutes" do
    @space_entry.end_time = @space_entry.start_time + 90.minutes
    assert_equal 90, @space_entry.duration
  end
  

end
