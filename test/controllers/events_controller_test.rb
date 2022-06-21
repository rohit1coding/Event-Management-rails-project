require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "index action" do
    get :index
    assert_response :success
  end

  test "Create an Event" do
    get :new
    assert_response :success
  end

end
