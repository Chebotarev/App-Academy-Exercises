class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def new
    render json: params
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render(
        json: @user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    begin
      @user = User.find(params[:id])
      render json: @user

    rescue ActiveRecord::RecordNotFound => e
      render json: e.message
    end

  end

  def update
    begin
      @user = User.find(params[:id])
      @user.update_attributes(user_params)
      if @user.save
        render json: @user
      else
        render(
          json: @user.errors.full_messages, status: :unprocessable_entity
        )
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: e.message
    end


  end

  def destroy
    begin
      @user = User.find(params[:id])
      @user.destroy
      render json: @user
    rescue ActiveRecord::RecordNotFound => e
      render json: e.message
    end
  end

  private
    def user_params
      params.require(:user).permit(:username)
    end
end
