class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue => exception
      session[:user_id] = nil
      flash[:notice] = "Session Expired Login Again!"
      redirect_to login_path
    end
  end
  
  def logged_in
    !!current_user
  end

  def authenticate_user
    if !logged_in
      flash[:alert] = "You have to login!"
      redirect_to login_path
    end
  end

end
