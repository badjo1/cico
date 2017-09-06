require 'test_helper'

class VenueUsersControllerTest < ActionController::TestCase
  
  def setup
    @venue_user = venue_users(:venue_user_fix_2)
    @user = @venue_user.user
    @other_venue_user = venue_users(:venue_user_fix_1)
    @other_user = users(:user_fix_1)
  end
  
  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  # test "should get new" do
  #   log_in_as(@user)
  #   get :new
  #   assert_response :success
  # end

  test "should redirect new when not logged in§" do
    get :new
    assert_redirected_to login_url
  end

  test "should redirect new when logged in as a non-admin" do
    log_in_as(@other_user)
    get :new
    assert_redirected_to root_url
  end

  test "should redirect create when not logged in" do
    post :create, user: { first_name: @user.first_name, last_name: @user.last_name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect create when logged in as a non-admin" do
    log_in_as(@other_user)
    post :create, user: { first_name: @user.first_name, last_name: @user.last_name, email: @user.email }
    assert_redirected_to root_url
  end




  # test "valid create" do
  #   log_in_as(@user) 
  #   post :create
  #   assert_redirected_to venue_users_path
  # end

  test "should redirect destroy when not logged in" do
      assert_no_difference 'VenueUser.count' do
        delete :destroy, id: @venue_user
      end
      assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete :destroy, id: @venue_user
    end
    assert_redirected_to root_url
  end

   test "should destroy venue_user" do
    log_in_as(@user)
    assert_difference('VenueUser.count', -1) do
      delete :destroy, id: @venue_user
    end
    assert_not flash.empty?
    assert_redirected_to venue_users_url
  end

   
  ##########################
  # TEST FOR ASSIGN ROLE
  #########################  
  test "should redirect assign role when not logged in" do
    get :assign_role, id: @venue_user, role: :admin
    assert_redirected_to login_url
  end

  test "should redirect assign role when logged in as a non-admin" do
    log_in_as(@other_user)
    get :assign_role, id: @venue_user, role: :admin
    assert_redirected_to root_url
  end

  test "should assign admin role" do
    log_in_as(@user)
    get :assign_role, id: @venue_user, role: :admin
    assert_redirected_to venue_users_url
  end



end
