class UsersController < ApplicationController
  def new
  end

  def create
  end

  def show
  end

  private

    def user_params
      params.require(:users).permit(:email, :password)
    end
end
