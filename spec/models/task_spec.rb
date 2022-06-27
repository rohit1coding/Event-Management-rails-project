require 'rails_helper'

RSpec.describe Task, type: :model do
  context "Validate test" do
    it "All Tasks" do
      task = Task.where(event_id: Event.first.id)
      expect(task).to be_truthy
    end
    
    it "Create User task" do
      event_id = Event.first.id
      task = Task.new(name:"Rohit Shaw", event_id: event_id).save
      expect(task).to be_truthy
    end

    it "Find task by ID" do
      task_id = Task.first.id
      task = Task.find(task_id)
      expect(task).to be_truthy
    end

    it "Update task" do
      task = Task.first
      task.update(name:"Rohit test Updated")
      expect(task).to be_truthy
    end

    it "Destroy User task" do
      current_task = Task.first
      expenses = current_task.expenses.all
      expenses.each do |expense|
        expense.destroy
      end
      task = current_task.destroy
      expect(task).to be_truthy
    end
  end
end
