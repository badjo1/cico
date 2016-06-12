require 'test_helper'

class SpacesControllerTest < ActionController::TestCase
  setup do
    @venue_user = venue_users(:venue_user_fix_2)
    @user = @venue_user.user
    @other_user = users(:user_fix_1)
    @space = spaces(:space_fix_2)
    @other_space = spaces(:space_fix_1)
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  test "should get index" do
    log_in_as(@user)
    get :index
    assert_response :success
    assert_not_nil assigns(:spaces)
  end

  test "should redirect new when not logged in or when logged in as a non-admin" do
    get :new
    assert_redirected_to login_url
    log_in_as(@other_user)
    get :new
    assert_redirected_to root_url
  end

  test "should get new" do
    log_in_as(@user)
    get :new
    assert_response :success
  end

  test "should redirect create when not logged in or when logged in as a non-admin" do
    post :create, space: { name: @space.name}
    assert_redirected_to login_url
    log_in_as(@other_user)
    post :create, space: { name: @space.name}
    assert_redirected_to root_url
  end

  test "should create space" do
    log_in_as(@user)
    assert_difference('Space.count') do
      post :create, space: { name: @space.name}
    end
    assert_redirected_to spaces_path
  end

  test "should get edit" do
    log_in_as(@user)
    get :edit, id: @space
    assert_response :success
  end


  test "should redirect update space when not logged in or when logged in as a non-admin" do
    patch :update, id: @space, space: { name: @space.name, venue_id: @space.venue_id }
    assert_redirected_to login_url
    log_in_as(@other_user)
    patch :update, id: @space, space: { name: @space.name, venue_id: @space.venue_id }
    assert_redirected_to root_url
  end

  test "should redirect update space when space is not in venue" do
    log_in_as(@user)
    patch :update, id: @other_space, space: { name: @space.name, venue_id: @space.venue_id }
    assert_redirected_to root_url
  end

  test "should update space" do
    log_in_as(@user)
    patch :update, id: @space, space: { name: @space.name, venue_id: @space.venue_id }
    #assert_redirected_to space_path(assigns(:space))
    assert_redirected_to spaces_path
  end

  test "should destroy space" do
    log_in_as(@user)
    assert_difference('Space.count', -1) do
      delete :destroy, id: @space
    end
    assert_redirected_to spaces_path
  end
end
