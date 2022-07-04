require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) {
    User.new(name: "rohit test", email: "rohit123@gmail.com", password: "1234")
  }

  before do
    user.save
  end

  # context "associations" do
	# 	it "User has many events" do
  #     should have_many(:events)
  #   end
	# end

  context "Validate test" do    
    it "User name can't be blank" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "User email can't be blank" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "User password can't be blank" do
      user.password = nil
      expect(user).to_not be_valid
    end
    
    it "User should be able to Sign Up" do
      user.save
      expect(user).to be_truthy 
    end

    it "User should be able to Login" do
      user = User.find(User.first.id)
      expect(user).to be_truthy 
    end   
  end
end
