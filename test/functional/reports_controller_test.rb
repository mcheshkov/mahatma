require 'test_helper'

class ReportsControllerTest < ActionController::TestCase
  test "should get department_ips" do
    get :department_ips
    assert_response :success
  end

end
