class SpaceEntriesController < ApplicationController

  def edit
    @space_entry = SpaceEntry.find(params[:id])
    @space_entry.start_time =  Time.at( params[:start_time].to_i) if  params[:start_time]
    @space_entry.end_time =  Time.at( params[:end_time].to_i) if  params[:end_time]
    @space_entry.space_id =  params[:space_id].to_i if  params[:space_id]    
    render 'edit'
  end

  def update
    @space_entry = SpaceEntry.find(params[:id])
    if @space_entry.update_attributes(space_entry_params)
      flash[:success] = "Appointment updated"
      redirect_to book_path(@space_entry.start_time.to_i)
    else
      flash[:error] = "Error occured when updating appointment"
      render 'edit'
    end
  end

  private

    def space_entry_params
      params.require(:space_entry).permit(:start_time, :end_time, :space_id)
    end

end
