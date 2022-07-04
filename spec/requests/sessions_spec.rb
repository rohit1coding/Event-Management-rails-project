require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  # describe "GET /new" do
  #   it "returns register page to user" do
  #     get signup_path
  #     expect(response.status).to eq(200)
  #     expect(response).to render_template(:new)
  #   end
  # end
  # describe "POST /create" do
    
  #   it "create a new user and redirects to root path" do
  #     expect {
  #         post login_url, params: {
  #           user: {
  #             name: 'Rohit Test',
  #             email: 'rohit1211@gmail.com',
  #             password: '1234456'
  #           }
  #         }
  #       }.to change(User, :count).by(1)
  #     expect(response).to redirect_to(root_path)
  #     session[:user_id] = 1
  #     expect(session[:user_id]).to eq(1)
      
  #   end
   
    # it "render register page with invalid attributes" do
    #   expect {
    #       post sign_up_url, params: {
    #         user: {
    #           username: 'xyz',
    #           email: '',
    #           password: '1234', 
    #           password_confirmation: '1234'
    #         }
    #       }
    #     }.to change(User, :count).by(0)
    #   expect(response).to render_template(:new)
    # end

  # end
end
