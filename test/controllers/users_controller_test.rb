require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  
  def setup
    @user = users(:user_fix_1)
    @other_user = users(:user_fix_other)
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { first_name: @user.first_name, last_name: @user.last_name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

 test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get :edit, id: @user
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch :update, id: @user, user: { name: @user.last_name, email: @user.email }
    assert flash.empty?
    assert_redirected_to root_url
  end


end
