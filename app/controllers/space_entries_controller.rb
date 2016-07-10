class SpaceEntriesController < ApplicationController

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

  private

    def space_entry_params
      params.require(:space_entry).permit(:start_time, :end_time, :space_id)
    end

end
