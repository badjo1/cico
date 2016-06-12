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

  test "subdomain should be present" do
    @venue.subdomain = "     "
    assert_not @venue.valid?
  end

  test "name should not be too long" do
    @venue.name = "a" * 51
    assert_not @venue.valid?
  end

  test "subdomain should not be too long" do
    @venue.subdomain = "a" * 51
    assert_not @venue.valid?
  end

test "subdomain validation should accept valid subdomain" do
    valid_subdomains = %w[hof20 s-c-a HOF20]
    valid_subdomains.each do |valid_subdomain|
      @venue.subdomain = valid_subdomain
      assert @venue.valid?, "#{valid_subdomain.inspect} should be valid"
    end
  end

  test "subdomain validation should reject invalid subdomain" do
    invalid_subdomains = %w[www info@hof hof.nl]
    invalid_subdomains.each do |invalid_subdomain|
      @venue.subdomain = invalid_subdomain
      assert_not @venue.valid?, "#{invalid_subdomain.inspect} should be invalid"
    end
  end

end
