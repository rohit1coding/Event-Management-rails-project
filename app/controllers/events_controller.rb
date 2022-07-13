class EventsController < ApplicationController
  before_action :authenticate_user
  
  def index
    @events = current_user.events.all
  end

  def new
    @event = Event.new
  end
  
  def create
    @event = current_user.events.new(event_params)
    if @event.save
      flash[:notice] = "Event #{@event.name} successfully created"
      redirect_to @event
    else
      flash[:alert] = "Something went wrong"
      render 'new'
    end
  end
  
  def edit
    current_event
  end
  
  def update
    current_event
    if @event.update(event_params)
      flash[:notice] = "Event successfully Updated!"
      redirect_to @event
    else
      flash[:alert] = "Something went wrong"
      render 'edit'
    end
  end
  
  def show
    current_event
    @tasks = @event.tasks.all
    @expenses = current_event.expenses.all
    @total_expenses = 0
    @expenses.each do |expense|
      @total_expenses = @total_expenses + expense.amount
    end
  end

  def destroy
    current_event
    @name = @event.name
    destroy_current_event_tasks
    @event.destroy
    respond_to do |format|
      format.html { redirect_to @event, alert: "Event #{@name} was successfully deleted." }
    end
  end
  
  def destroy_current_event_tasks
    @tasks = current_event.tasks.all
    @tasks.each do |task|
      @expenses = task.expenses.all
      @expenses.each do |expense|
        expense.destroy
      end
      task.destroy
    end
  end

  def current_event
    @event = Event.find(params[:id])
  end

  def event_params 
    params.require(:event).permit(:name)
  end

end
