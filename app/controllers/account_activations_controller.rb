class AccountActivationsController < ApplicationController
  before_action :correct_activation, only: [:edit, :update]

  def edit
  end

  def update
    if @user.update_attributes(user_params)
     @user.activate
     log_in @user
     flash[:success] = "Account activated!"
     redirect_to @user
    else
      render 'edit'
    end
  end

  #   def edit
  #   user = User.find_by(email: params[:email])
  #   if user && !user.activated? && user.authenticated?(:activation, params[:id])
  #     user.activate
  #     log_in user
  #     flash[:success] = "Account activated!"
  #     redirect_to user
  #   else
  #     flash[:danger] = "Invalid activation link"
  #     redirect_to root_url
  #   end
  # end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password,
                                   :password_confirmation)
    end


    def correct_activation
      @user = User.find_by(email: params[:email])
      if @user && !@user.activated? && @user.authenticated?(:activation, params[:id])
        #donothing
      else
        flash[:danger] = "Invalid activation link"
        redirect_to root_url
      end
    end
  

end
