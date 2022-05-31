class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in, :new_notification_count, :notifications

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

  def generate_notification(message, admin_id, user_id, event_id, task_id)
    @notification = Notification.new(message:message, admin_id:admin_id, user_id:user_id, event_id: event_id, task_id: task_id)
    @notification.save
  end

  def notifications
    @notifications = current_user.notifications.all 
  end

  def new_notification_count
    @notifications_count =current_user.notifications.where(is_read: false).count
  end
end
