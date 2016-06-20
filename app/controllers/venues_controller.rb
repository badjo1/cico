class VenuesController < ApplicationController
  before_action :logged_in_user
 
  def show
    set_selected_date
    current_venue = current_user.venue
    @spaces = current_venue.spaces
    @space_entries = current_venue.space_entries.includes(:event)
      .where(start_time: (@selected_date.beginning_of_day..@selected_date.end_of_day))
  end

  def week
    if (params[:unix])
      @selected_date =  Time.at( params[:unix].to_i)       
    end
    @selected_date ||= Time.zone.now
    current_venue = current_user.venue
    @spaces = current_venue.spaces
    @space_entries = current_venue.space_entries.includes(:event)
      .where(start_time: (@selected_date.beginning_of_week..@selected_date.end_of_week))
      .order(:start_time)
    render 'show'
  end

   def booked
    @space_entries = SpaceEntry.all
    respond_to do |format|
      format.html
      format.json
      # format.json { render json: @@posts }
    end
  end

  private 
    def set_selected_date
      if (params[:unix])
        @selected_date =  Time.at( params[:unix].to_i)       
      end
      @selected_date ||= Time.zone.now
    end


end
