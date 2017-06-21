class VenueUsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :new, :create, :destroy]
  before_action :admin_user,     only: [:destroy, :new, :create]

  def planned_events
    @venue_user = VenueUser.find(params[:id])
    @events = @venue_user.planned_events.paginate(page: params[:page], per_page: 50)
    render 'show'
  end

  def archived_events
    @venue_user = VenueUser.find(params[:id])
    @events = @venue_user.archived_events.paginate(page: params[:page], per_page: 50)
    # @events = @venue_user.events.joins(:space_entries)
    #   .where("space_entries.start_time < ?", Time.zone.now.beginning_of_day)
    #   .paginate(page: params[:page])
    #   .includes(:space_entries).order('space_entries.start_time DESC')
    render 'show'
  end

  def index
    venue_id = current_user.venue_id
    @venue_users = VenueUser.where(venue_id: venue_id).paginate(page: params[:page], per_page: 50)
  end

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:first_name, :prefix, :last_name, :email )
    existing_user = User.find_by(email: user_params[:email].downcase)
    if existing_user.present?
      #user already exists
      venue_user = VenueUser.new(user: existing_user, venue: current_user.venue)
      if venue_user.save
        flash[:success] = "User has already access and is member of this venue"
        redirect_to venue_users_url
      else
        flash[:danger] = "User '#{existing_user.fullname}' has already access to this venue"
        redirect_to venue_users_url
      end
    else
      #new user
      @user = User.new(user_params)
      if @user.save
        VenueUser.create!(user: @user, venue: current_user.venue) #no chance on duplicate venues 
        flash[:success] = "User added and is member of this venue"
        redirect_to venue_users_url
      else
        render 'new'
      end
    end
  end

  def destroy
    venue_user = VenueUser.find(params[:id])
    
    if venue_user.events.exists?
      flash[:danger] = "Can't not delete user if there are events"
      redirect_to venue_users_url
    else
      user = venue_user.user
      venue_user.destroy
      user.destroy if (user.venue_users.empty?)
      flash[:success] = "User deleted"
      redirect_to venue_users_url
    end
  end

  def set_current
    venue_user = VenueUser.find(params[:id])
    venue_user.set_current
    redirect_to root_url
  end

  private
  
end
