class UsersController < ApplicationController 
  def new
    if !!session[:user_id]
      redirect_to root_path
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    @password_confirmation = params[:user][:password_confirmation]
    if @user.password == @password_confirmation && @user.save
      flash[:notice] = "Account created successfully."
      redirect_to login_path
    else
      flash[:alert] = "Password mismatchted!"
      render 'new'
    end
  end

  def assigned_task
    authenticate_user
    @tasks = AssignedTask.where(user_id: current_user.id).order(updated_at: :desc)
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