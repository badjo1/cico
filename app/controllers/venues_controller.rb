class VenuesController < ApplicationController
  before_action :logged_in_user

  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.new(venue_params)
    if @venue.save
        @venue.venue_users.create!(
          user_id: current_user.user_id,
          role: VenueUser::ADMIN_ROLE_NAME,
          activated_at: Time.zone.now)
  
      flash[:success] = "Venue succesfull added"
      redirect_to user_url( current_user.user )
    else
      render 'new'
    end
  end


  private

    def venue_params
      params.require(:venue).permit(:name)
    end

end
