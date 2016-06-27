class EventsController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :destroy]
  before_action :correct_event, only: [:destroy]

  def show
    @schedule = params[:schedule_id]
    @event = Event.find(params[:id])
    render 'show'
  end

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
      redirect_to schedule_path('day',@space_entry.start_time.to_i)
    else
      render 'new'
    end
  end

  def destroy
    @schedule = params[:schedule_id]
    @event = Event.find(params[:id])
    selected_date = @event.space_entries.first.start_time
    @event.destroy
    flash[:success] = "Event deleted"
    redirect_to on_schedule_path(@schedule, selected_date.to_i)
  end

  private

    def event_params
      params.require(:event).permit(:event_name, space_entries_attributes: [:start_time, :end_time, :space_id,])
    end

    def correct_event
      @event = Event.find(params[:id])
      redirect_to(root_url) unless current_venue_user_id?(@event.venue_user_id)
    end
end
