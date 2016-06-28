class ScheduleController < ApplicationController
  before_action :logged_in_user

  def show
    @selected_date = (params[:unix]) ? Time.at( params[:unix].to_i) : Time.zone.now
    @schedule = params[:id]
    current_venue = current_user.venue
    @spaces = current_venue.spaces

    start_at = @selected_date.beginning_of_day
    start_at = @selected_date.beginning_of_week if @schedule == 'week'
    end_at = @selected_date.end_of_day
    end_at = @selected_date.end_of_week if @schedule == 'week'
        
    @space_entries = current_venue.space_entries.includes(event: {venue_user: :user})
      .where(start_time: (start_at..end_at))
      .order(:start_time)
    render 'show'
  end

end
