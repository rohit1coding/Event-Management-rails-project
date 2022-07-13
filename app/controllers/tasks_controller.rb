class TasksController < ApplicationController
  before_action :authenticate_user, :current_event
  def index 
    @tasks = @event.tasks.all.order(updated_at: :desc)
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
  end

  def edit 
    current_task
  end

  def update
    puts params
    @before_update_task = current_task.user_id
    if @task.update(task_params)
      if(!@before_update_task && !!current_task.user_id)
        @message = "#{@current_user.name} added you in the task #{@task.name}"
        assigned_task
        generate_notification(@message, current_user.id, @task.user_id, @event.id, @task.id)
        flash[:notice] = "User Allocated Sussessfully!"
      else
        flash[:notice] = "Task successfully Updated!"
      end
      redirect_to [@event, @task]
    else
      flash[:alert] = "Something went wrong"
      render 'edit'
    end
  end

  def assigned_task
    @assigned_task = AssignedTask.create(task_id:@task.id, admin_id:current_user.id, user_id: @task.user_id)
    @assigned_task.save
  end

  def unassigned_task
    @destroy_assigned_task = AssignedTask.where(task_id: @task.id, user_id:current_user.id).first
    @destroy_assigned_task.destroy
  end

  def destroy
    current_task
    @name = @task.name
    @assigned_tasks = AssignedTask.where(task_id:current_task.id)
    @assigned_tasks.each do |assigned_task|
      assigned_task.destroy
    end
    @task.destroy
    respond_to do |format|
      format.html { redirect_to @event, alert: "Task #{@name} was successfully deleted." }
    end
  end

  def is_completed
    @task = @event.tasks.find(params[:task_id])
    @is_completed = !@task.completed
    @task.update(completed: @is_completed)
    if @is_completed 
      @message = "#{@current_user.name} marked the task #{@task.name} as completed!"
    else 
      @message = "#{@current_user.name} marked the task #{@task.name} as incomplete!"
    end
    generate_notification(@message, current_user.id, @task.user_id, @event.id, @task.id)
    redirect_to [@event,@task]
  end
  
  def self_assign_task
    @task = @event.tasks.find(params[:task_id])
    @self_assign = !@task.self_assign
    @task.update(self_assign: @self_assign)
    if @self_assign
      @assigned_task = AssignedTask.create(task_id:@task.id, admin_id:current_user.id, user_id: current_user.id)
      @assigned_task.save
      @message = "You assigned yourself the task #{@task.name}!"
      generate_notification(@message, current_user.id, current_user.id, @event.id, @task.id)
    else  
      unassigned_task
      @message = "You removed yourself from the task #{@task.name}!"
      generate_notification(@message, current_user.id, current_user.id, @event.id, @task.id)
    end
    redirect_to [@event, @task]
  end

  def allocate 
    @task = @event.tasks.find(params[:task_id])
    @users = User.where.not(id:session[:user_id])
  end

  def deallocate_user
    @task = @event.tasks.find(params[:task_id])
    @message = "#{@current_user.name} removed you from the task #{@task.name}"
    @admin_id = session[:user_id]
    @user_id = @task.user_id
    @event_id = @event.id
    @task_id = @task.id
    @task.update(user_id: nil)
    generate_notification(@message, @admin_id, @user_id, @event_id, @task_id)
    @destroy_assigned_task = AssignedTask.where(task_id: @task.id, user_id:@user_id).first
    @destroy_assigned_task.destroy
    flash[:notice] = "A notification has been sent to #{User.find(@user_id).name}!"
    redirect_to [@event, @task]
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

end
