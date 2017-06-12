class FrequenciesController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]


  def new
    @event = Event.find(params[:event_id])
    @last_entry = @event.space_entries.last;
    @event.repeat_end_date = (@last_entry.start_time.to_date + 7.days).to_s
  end

  def create
    @event = Event.find(params[:event_id])
    @last_entry = @event.space_entries.last;
   
    @event.update_attributes(frequency_params)
    
    available_days = @event.repeat_end_date - @last_entry.start_time.to_date 

    (7..available_days).step(7).each do |n| 
      space_entry = @event.space_entries.build(
        start_time: @last_entry.start_time + n.days,
        end_time: @last_entry.end_time + n.days,
        space_id: @last_entry.space_id)
    end

     if @event.save
      flash[:success] = "#{@event.event_type} added"
      redirect_to schedule_event_path("day",@event)
    else
      render 'new'
    end
   
  end


  private

    def frequency_params
      params.require(:event).permit(:repeat_end_date)
    end



end
