class TasksController < ApplicationController
  before_action :authenticate_user
  def index 
    # @tasks = Task.all
    @tasks = Task.where(event_id: params[:event_id])
  end

  def new 
    @task = Task.new
  end

  def create
    @task = Task.new(name: task_params[:name], event_id: params[:event_id])
      if @task.save
        flash[:notice] = "Task #{@task.name} successfully created"
        redirect_to event_path(params[:event_id])
      else
        flash[:alert] = "Something went wrong"
        render 'new'
      end
  end

  def show 
    puts params
    current_task
  end

  def edit 
    current_task
  end

  def update
    current_task
    if @task.update(task_params)
      flash[:notice] = "Task successfully Updated!"
      redirect_to event_path(params[:event_id])
    else
      flash[:alert] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    current_task
    @name = @task.name
    @task.destroy
    respond_to do |format|
      format.html { redirect_to event_path(params[:event_id]), alert: "Task #{@name} was successfully deleted." }
    end
  end

  def current_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name)
  end
end
