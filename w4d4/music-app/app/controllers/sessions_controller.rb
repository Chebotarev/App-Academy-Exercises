class SessionsController < ApplicationController
  helper_method :current_user
  helper_method :logged_in?
  helper_method :logout!

  def new
    @user = User.new
  end

  def create
    email = params[:users][:email]
    password = params[:users][:password]
    @user = User.find_by_credentials(email, password)
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << "Couldn't Login That User!"
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
