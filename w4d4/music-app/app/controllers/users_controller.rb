class UsersController < ApplicationController
  helper_method :current_user
  helper_method :logged_in?

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

    def user_params
      params.require(:users).permit(:email, :password)
    end
end
