require 'rails_helper'

RSpec.describe Expense, type: :model do
  context "Validate test" do
    it "All expenses" do
      expense = Expense.where(task_id: Task.first.id)
      expect(expense).to be_truthy
    end
    
    it "Create User expense" do
      task_id = Task.first.id
      expense = Expense.new(name:"Rohit Shaw", amount:"5000", task_id: task_id).save
      expect(expense).to be_truthy
    end

    it "Find expense by ID" do
      expense_id = Expense.first.id
      expense = Expense.find(expense_id)
      expect(expense).to be_truthy
    end

    it "Update expense" do
      expense = Expense.first
      Expense.update(name:"Rohit test Updated")
      expect(expense).to be_truthy
    end

    it "Destroy User expense" do
      current_expense = Expense.first
      expense = current_expense.destroy
      expect(expense).to be_truthy
    end
  end
end
