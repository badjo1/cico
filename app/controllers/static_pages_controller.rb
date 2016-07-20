class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @events = current_user.space_entries.order(created_at: :desc).paginate(page: params[:page])
    end
  end

  def help
  end
end
