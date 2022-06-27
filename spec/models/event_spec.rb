require 'rails_helper'

RSpec.describe Event, type: :model do
  context "Validate test" do
    it "User All Events" do
      event = Event.where(user_id:User.first.id)
      expect(event).to be_truthy
    end
    
    it "Create User Event" do
      user_id = User.first.id
      event = Event.new(name:"Rohit Shaw", user_id: user_id).save
      expect(event).to be_truthy
    end

    it "Find Event by ID" do
      event_id = Event.first.id
      event = Event.find(event_id)
      expect(event).to be_truthy
    end

    it "Update Event" do
      event = Event.first
      event.update(name:"Rohit test Updated")
      expect(event).to be_truthy
    end

    it "Destroy User Event" do
      current_event = Event.first
      tasks = current_event.tasks.all
      tasks.each do |task|
      expenses = task.expenses.all
      expenses.each do |expense|
        expense.destroy
      end
      task.destroy
    end
      event = current_event.destroy
      expect(event).to be_truthy
    end
  end
end
