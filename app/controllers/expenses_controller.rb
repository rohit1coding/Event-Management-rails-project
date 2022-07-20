class ExpensesController < ApplicationController
  before_action :authenticate_user, :current_event
  def index 
    @expenses = @event.expenses.all.order(updated_at: :desc)
  end

  def new 
    @expense = Expense.new
  end

  def create 
    @expense = @event.expenses.new(expense_params)
     if @expense.save 
      flash[:notice] = "Expense #{@expense.name} successfully created"
      redirect_to [@event, @expense]
     else
      flash[:alert] = "Something went wrong"
      render 'new'
     end
  end

  def show 
    current_expense
  end

  def edit 
    current_expense
  end

  def update 
    current_expense
    if @expense.update(expense_params)
      flash[:notice] = "Expense updated successfully"
      redirect_to [@event, @expense]
    else
      flash[:alert] = "Something went wrong"
      render 'edit'
    end
  end

  def destroy
    current_expense
    @name = @expense.name
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to @event, alert: "Expense #{@name} was successfully deleted." }
    end
  end
  
  def allocate_task
    @expense = @event.expenses.find(params[:expense_id])
    @tasks = Task.where(event_id: current_event.id)
  end

  def deallocate_task
    @expense = @event.expenses.find(params[:expense_id])
    @expense.update(task_id: nil)
    redirect_to [@event, @expense]
  end

  def current_event
    @event = Event.find(params[:event_id])
  end

  def current_task
    # @task = @event.tasks.find(params[:task_id])
    @task = Task.find(params[:task_id])
  end
  
  def current_expense
    @expense = @event.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, :task_id)
  end
end
