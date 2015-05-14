class SessionsController < ApplicationController
  before_action :already_logged_in, except: :destroy

  def new
    @user = User.new
  end

  def create
    login_name = session_params[:username]
    pass = session_params[:password]
    @user = User.find_by_credentials(login_name, pass)

    if @user
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] << @user.errors.full_messages
      render :new
    end
  end

  def destroy
    @user = User.find_by(session_token: session[:session_token])
    logout(@user)
    redirect_to new_session_url
  end

  private

    def session_params
      params.require(:session).permit(:username, :password)
    end
end

# Build a SessionsController.
# Add a singular session resource.
# There is at most one session in the user's life; they don't need to have routes to address multiple sessions.
# Write a new form that has the user input their username and password.
# In SessionsController#create:
# Verify the user_name/password.
# (Re)set the User's session_token.
# Update the session.
# Redirect the user to the cats index.
