class SpaceEntriesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]


  def new
    @event = Event.find(params[:event_id])
    #last_booked must before build
    last_booked = @event.space_entries.last
    @space_entry = @event.space_entries.build
    @space_entry.space_id = params[:space_id]

    if (last_booked)
      @space_entry.space_id = last_booked.space_id if !@space_entry.space_id
      case params[:repeat]
        when "7days"
          @space_entry.start_time = last_booked.start_time + 7.days
        when "14days"
          @space_entry.start_time = last_booked.start_time + 14.days
        when "1month"
          @space_entry.start_time = last_booked.start_time + 1.month
        else
          @space_entry.start_time = last_booked.start_time
      end      
      if @space_entry.start_time
        @space_entry.end_time = @space_entry.start_time + last_booked.duration.minutes
       end
    end
  end

  def create
    @event = Event.find(params[:event_id])
    @space_entry = @event.space_entries.build(space_entry_params)
    if @space_entry.save
      flash[:success] = "Added entry of #{@event.event_type}"
      redirect_to schedule_event_path("day",@event)
    else
      render :new
    end
  end

  def edit
    @schedule = params[:schedule_id]
    
    @space_entry = SpaceEntry.find(params[:id])
    @space_entry.start_time =  Time.at( params[:start_time].to_i) if  params[:start_time]
    @space_entry.end_time =  Time.at( params[:end_time].to_i) if  params[:end_time]
    @space_entry.space_id =  params[:space_id].to_i if  params[:space_id]    
    render 'edit'
  end

  def update
    @schedule = params[:schedule_id]
    @space_entry = SpaceEntry.find(params[:id])
    if @space_entry.update_attributes(space_entry_params)
      flash[:success] = "#{@space_entry.event.event_type} updated"
      redirect_to on_schedule_path(@schedule, @space_entry.start_time.to_i)
    else
      render 'edit'
    end
  end

  def destroy
    @space_entry = SpaceEntry.find(params[:id])
    @event = @space_entry.event
    #redirect_to root_path unless current_user.events.include?(@events)
    if @event.space_entries.length > 1
      @space_entry.destroy
      flash[:success] = "entry of #{@event.event_type} deleted"
    else
      flash[:danger] = "can not deleted entry of #{@event.event_type} because there is only one left"
    end
    redirect_to schedule_event_path("day",@event)
  end


  private

    def space_entry_params
      params.require(:space_entry).permit(:start_time, :end_time, :space_id)
    end

    def set_space
      @space = Space.find(params[:id])
      #Correct space in venue
      redirect_to root_path unless current_user.venue.spaces.include?(@space)
    end


end
