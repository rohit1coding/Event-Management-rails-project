class UsersController < ApplicationController 
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save 
      flash[:notice] = "Account created successfully."
      redirect_to root_path
    else
      # flash.now[:alert] = "Enter a valid input!"
      render 'new'
    end
  end

  def user_params 
    params.require(:user).permit(:name, :email, :password)
  end
end