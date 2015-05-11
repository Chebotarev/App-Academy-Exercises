class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def new
    render json: params
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    begin
      user = User.find(params[:id])
      render json: user

    rescue ActiveRecord::RecordNotFound => e
      render json: e.message

    end

  end

  def update
    user = User.find(params[:id])

    user.update_attributes!(user_params)

    user.save

    render json: user
  end

  def destroy
    user = User.find(params[:id])

    user.destroy

    render text: "User has been destroyed"
  end

  private
    def user_params
      params[:user].permit(:name, :email)
    end
end
