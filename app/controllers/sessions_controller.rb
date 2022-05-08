class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      session[:user_name] = user.name
      flash[:notice] = "Logged in successfully!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password!"
      render 'new'
    end
  end
   
  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logout successfully!"
    redirect_to login_path
  end
end