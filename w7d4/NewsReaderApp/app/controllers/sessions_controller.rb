class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(user_params[:username],user_params[:password])

    if @user
      log_in_user!(@user)
      render :json => @user
    else
      render :json => @user.errors.full_messages, status: 422
    end
  end

  def destroy
    user = current_user
    log_out_user
    render :json => user
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
