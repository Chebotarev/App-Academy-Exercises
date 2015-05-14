class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_session ||= Session.find_by(session_token: session[:session_token])
    @current_user ||= User.find(@current_session.user_id)
  end

  def login(user)
    new_session = Session.create!(
    user_id: user.id,
    user_agent: request.env["HTTP_USER_AGENT"]
    )

    session[:session_token] = new_session
  end

  def logout(user)
    session[:session_token] = nil
    # Session.delete(row)
    user.reset_session_token!
  end

  private

  def already_logged_in
    redirect_to cats_url if current_user
  end
end
