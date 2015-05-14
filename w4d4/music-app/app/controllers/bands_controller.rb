class BandsController < ApplicationController
  before_action :verify_login

  def index

  end

  def new

  end

  def create

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def band_params
      params.require(:bands).permit(:name)
    end

    def verify_login
      redirect_to new_session_url unless logged_in?
    end
end
