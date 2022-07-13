class ExpensesController < ApplicationController
  before_action :authenticate_user, :current_event
  def index 
    @expenses = @event.expenses.all
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
    params.require(:expense).permit(:name, :amount)
  end
end
