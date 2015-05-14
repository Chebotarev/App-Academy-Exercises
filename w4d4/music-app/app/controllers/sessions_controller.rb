class SessionsController < ApplicationController
  helper_method :current_user
  helper_method :logged_in?
  helper_method :logout!

  def new
  end

  def create
    @user = User.find_by_email(session_params)
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def destroy
    logout!(current_user)
    redirect_to new_session_url
  end

  private

    def session_params
      params.require(:users).permit(:email, :password)
    end
end
