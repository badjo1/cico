class VenueUsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :destroy]
  before_action :admin_user,     only: [:destroy, :new, :create]

  def show
    @venue_user = VenueUser.find(params[:id])
  end

  def index
    venue_id = current_user.venue_id
    @venue_users = VenueUser.where(venue_id: venue_id).paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :last_name, :email )
    @user = User.new(user_params)
    if @user.save
      VenueUser.create!(user: @user, venue: current_user.venue)
      @user.send_activation_email
      flash[:success] = "Send email to user to activate the account"
      redirect_to venue_users_url
    else
      render 'new'
    end
  end

  def destroy
    venue_user = VenueUser.find(params[:id])
    
    if venue_user.events.extists?
      flash[:danger] = "Can't not delete user if there are events"
      redirect_to venue_users_url
    end

    user = venue_user.user
    venue_user.destroy
    
    user.destroy if (user.venue_user.exitst?)
    
    flash[:success] = "User deleted"
    redirect_to venue_users_url
  end

  private
  
end
