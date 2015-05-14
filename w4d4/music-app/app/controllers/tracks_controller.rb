class TracksController < ApplicationController
  before_action :verify_login

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

    def track_params
      params.require(:tracks).permit(:album, :name, :variety, :lyrics)
    end

    def verify_login
      redirect_to new_session_url unless logged_in?
    end
end
