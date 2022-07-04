require 'rails_helper'

RSpec.describe "Events", type: :request do
  current_user = User.first
  # puts current_user.name

  describe "GET /events" do
    it "Event Lists" do
      get events_path
      expect(response).to be_truthy
    end
    it "New Event" do
      get "/events/new"
      expect(response).to be_truthy
    end
    it "Edit Event" do
      get "/events/edit"
      expect(response).to be_truthy
    end
    it "show Event" do
      get "/events/show"
      expect(response).to be_truthy
    end
    # it "delete Event by id" do 

    # end
  end

  # describe "GET /show" do
  #   it "show Event" do
  #     event = current_user.events.new(name:"Rohit Test").save

  #     get event_path(event)
  #     expect(response).to be_successful
  #   end
  # end
end
