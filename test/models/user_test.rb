require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "Bart", last_name: "Bloemers", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    @user.save!

  end

  test "should be valid" do
    assert @user.valid?
  end

 test "firstname should be present" do
    @user.first_name = ""
    assert_not @user.valid?
  end

  test "lastname should be present" do
    @user.last_name = ""
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "firstname should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "fullname should be valid" do
    assert_equal @user.fullname, "#{@user.first_name} #{@user.last_name}"
    @user.first_name = ""
    assert_equal @user.fullname, @user.last_name
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save!
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password can blank when not activated" do
    not_activated_user = User.new(first_name: "Bart", last_name: "Bloemers", email: "min@example.com")
    not_activated_user.save!
    assert not_activated_user.valid?
  end


  test "password should be present (nonblank) when activated" do
    @user.activated = true
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length when activated" do
    @user.activated = true
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end


  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "fullname should concat first_name prefix last_name" do
    @user.first_name = "Test"
    @user.prefix = "van der"
    @user.last_name = "Testcase"
    assert_equal @user.fullname, "Test van der Testcase"
  end

end
