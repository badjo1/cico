class StaticPagesController < ApplicationController
  def home
    if logged_in?
      #@events = current_user.space_entries.order(created_at: :desc).paginate(page: params[:page])
      @events = current_user.planned_events.paginate(page: params[:page], per_page: 50)
    
    end
  end

  def help
  end
end
