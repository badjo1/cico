class EventsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]

  def new
    start_unix = params[:start_time]
    end_unix = params[:end_time]
    space_id = params[:space_id]

    @event = Event.new(event_name: "")
    @space_entry = @event.space_entries.build
    @space_entry.start_time = Time.at( start_unix.to_i )  unless start_unix.nil?
    @space_entry.end_time = Time.at( end_unix.to_i ) unless end_unix.nil?
    @space_entry.space_id = space_id.to_i
    
    respond_to do |format|
      format.html #new.html.erb
      format.json { render json: @space_entry}
    end
  end

  def create
    @event = Event.new(event_params)
    @event.venue_user = current_user 
    @space_entry = @event.space_entries.first
    if @event.save
      flash[:success] = "Appointment added"
      redirect_to book_path(@space_entry.start_time.to_i)
    else
      render 'new'
    end
  end

  private

    # def event_params
    #   params[:space_entry].require(:event).permit(:event_name)
    # end

    def event_params
      params.require(:event).permit(:event_name, space_entries_attributes: [:start_time, :end_time, :space_id,])
    end
end
