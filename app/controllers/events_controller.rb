class EventsController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :create, :edit, :update, :destroy]
  before_action :correct_event, only: [:edit, :update, :destroy]

  def show
    @schedule = params[:schedule_id]
    @event = Event.find(params[:id])
    render 'show'
  end

  def new
    start_unix = params[:start_time]
    end_unix = params[:end_time]
    space_id = params[:space_id]

    last_inserted = Event.where(venue_user_id: current_user).order("created_at").last 
    default_name = last_inserted ? last_inserted.event_name : "consult"

    @event = Event.new(event_name: default_name)
    @event.venue_user = current_user if current_user.admin?
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
    if (current_user.admin?)
      selected_user = VenueUser.find(params[:event][:venue_user_id])
      @event.venue_user = selected_user
    end
    @space_entry = @event.space_entries.first
    if @event.save
      flash[:success] = "#{@event.event_type} added"
      redirect_to on_schedule_path('day',@space_entry.start_time.to_i)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
   if @event.update_attributes(event_params)
      flash[:success] = "Updated #{@event.event_type}"
      redirect_to schedule_event_path("day",@event)
    else
      render :edit
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

  def ical
    event = Event.find(params[:id])
    cal = Icalendar::Calendar.new

    event_summary = "#{event.event_name} by #{event.venue_user.fullname}" 

    event.space_entries.includes(:space).each do |space_entry| 
      cal.event do |e| # This automatically adds the event to the calendar
        e.dtstart     = space_entry.start_time
        e.dtend       = space_entry.end_time
        e.summary     = event_summary 
        e.description = event.event_type
        e.url         = schedule_event_url("day",event)
        #e.ip_class    = "PRIVATE"
      end
    end
    
    cal.publish
    respond_to do |format|
      format.ics { render :text => cal.to_ical }  
    end

  end

  private

    def event_params
      params.require(:event).permit(:event_type, :event_name, :venue_user_id, space_entries_attributes: [:start_time, :end_time, :space_id,])
    end

    def correct_event
      @event = Event.find(params[:id])
      redirect_to(root_url) unless current_user.admin? || current_venue_user_id?(@event.venue_user_id)
    end
end
