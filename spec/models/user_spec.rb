require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validate test" do    
    it "User Sign Up" do
      user = User.new(name:"Rohit Shaw", email:"rohit1@gmail.com", password:"rohit").save
      expect(user).to be_truthy 
    end

    it "User Login" do
      user = User.find(User.first.id)
      expect(user).to be_truthy 
    end   
  end
end
