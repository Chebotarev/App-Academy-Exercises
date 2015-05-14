class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def login!(user)
    login_user = User.find_by_credentials(user.email, params[:users][:password])
    session[:session_token] = login_user.reset_session_token!
  end

  def logout!(user)
    session[:session_token] = nil
    user.reset_session_token!
  end
end
