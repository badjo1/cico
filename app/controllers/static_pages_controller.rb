class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @events = current_user.events.paginate(page: params[:page])
    end
  end

  def help
  end
end
