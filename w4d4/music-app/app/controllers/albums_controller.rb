class AlbumsController < ApplicationController
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

    def album_params
      params.require(:albums).permit(:band, :name, :production)
    end

    def verify_login
      redirect_to new_session_url unless logged_in?
    end
end
