class TasksController < ApplicationController
  before_action :authenticate_user, :current_event
  def index 
    # @tasks = Task.all
    @tasks = @event.tasks.all
  end

  def new 
    @task = Task.new
  end

  def create
    # @task = Task.new(name: task_params[:name], event_id: params[:event_id])
    @task = @event.tasks.new(task_params)
      if @task.save
        flash[:notice] = "Task #{@task.name} successfully created"
        redirect_to [@event, @task]
      else
        flash[:alert] = "Something went wrong"
        render 'new'
      end
  end

  def show 
    current_task
    @expenses = current_task.expenses.all
  end

  def edit 
    current_task
  end

  def update
    current_task
    if @task.update(task_params)
      flash[:notice] = "Task successfully Updated!"
      redirect_to [@event, @task]
    else
      flash[:alert] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    current_task
    @name = @task.name
    destroy_current_task_expenses
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @event, alert: "Task #{@name} was successfully deleted." }
    end
  end

  def current_event
    @event = Event.find(params[:event_id])
  end

  def current_task
    @task = @event.tasks.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:name)
  end

  def destroy_current_task_expenses
    @expenses = current_task.expenses.all
    @expenses.each do |expense|
      expense.destroy
    end
  end
end
