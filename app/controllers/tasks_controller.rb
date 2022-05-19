class TasksController < ApplicationController
  before_action :authenticate_user, :current_event
  def index 
    @tasks = @event.tasks.all
  end

  def new 
    @task = Task.new
  end

  def create
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
    if !!@task.deadline && !@task.completed && @task.deadline < Date.today
      flash[:alert] = "Deadline passed for task #{@task.name}"
    end
    @expenses = current_task.expenses.all
    @total_expenses = 0
    @expenses.each do |expense|
      @total_expenses = @total_expenses + expense.amount
    end
  end

  def edit 
    current_task
  end

  def update
    puts params
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

  def is_completed
    @task = @event.tasks.find(params[:task_id])
    @is_completed = !@task.completed
    @task.update(completed: @is_completed)
    redirect_to [@event,@task]
  end
  
  def allocate 
    @task = @event.tasks.find(params[:task_id])
    @users = User.where.not(id:session[:user_id])
  end

  def deallocate_user
    puts params
    @task = @event.tasks.find(params[:task_id])
    @task.update(user_id: nil)
    redirect_to @event
  end

  def form_deadline 
    @task = @event.tasks.find(params[:task_id])
  end

  def current_event
    @event = Event.find(params[:event_id])
  end

  def current_task
    @task = @event.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name,:deadline, :user_id)
  end

  def change
    puts task_params
    redirect_to [@event, @task, :show]
  end

  def destroy_current_task_expenses
    @expenses = current_task.expenses.all
    @expenses.each do |expense|
      expense.destroy
    end
  end

end
