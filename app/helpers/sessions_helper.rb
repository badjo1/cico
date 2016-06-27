module SessionsHelper

    # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #Returns the user corresponding to the remember token cookie.
  # def current_user
  #   if (user_id = session[:user_id])
  #     @current_user ||= User.find_by(id: user_id)
  #   elsif (user_id = cookies.signed[:user_id])
  #     user = User.find_by(id: user_id)
  #     if user && user.authenticated?(cookies[:remember_token])
  #       log_in user
  #       @current_user = user
  #     end
  #   end
  # end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= VenueUser.find_most_recent_by(user_id)
    elsif (user_id = cookies.signed[:user_id])
      venue_user = VenueUser.find_most_recent_by(user_id)
      user = venue_user.user
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = venue_user
      end
    end
  end

  
  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user.user
  end

  # Returns true if the given venue user is the current venue user
  def current_venue_user?(venue_user)
    venue_user == current_user
  end

  # Returns true if the given id is the current venue user id
  def current_venue_user_id?(id)
    id == current_user.id
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user.user)
    session.delete(:user_id)
    @current_user = nil
  end

 # Redirects to stored location (or to the default).
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
  
  # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
   def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
