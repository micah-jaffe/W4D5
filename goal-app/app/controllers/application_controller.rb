class ApplicationController < ActionController::Base
  
  def current_user
    @current_user ||= User.find_by(session_token: sessions[:session_token])
  end
  
  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    @current_user = nil
  end
  
end
