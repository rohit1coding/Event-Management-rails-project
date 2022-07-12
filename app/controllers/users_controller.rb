class UsersController < ApplicationController 
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save 
      flash[:notice] = "Account created successfully."
      redirect_to login_path
    else
      render 'new'
    end
  end

  def assigned_task
    authenticate_user
    @tasks = current_user.notifications.all
  end

  def user_params 
    params.require(:user).permit(:name, :email, :password)
  end

  def notifications
    @notifications = current_user.notifications.all.reverse
  end
  
  def mark_all_as_read
    @notifications =current_user.notifications.where(is_read: false)
    @notifications.each do |notification|
      notification.update(is_read:true)
    end
    redirect_to notifications_path
  end
  
end