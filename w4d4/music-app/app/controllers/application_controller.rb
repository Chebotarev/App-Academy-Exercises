class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    user = User.find_by_credentials(params[:users][:email], params[:users][:password])
    session[:session_token] = user.reset_session_token!
  end

  def log_out!(user)
  end
end
