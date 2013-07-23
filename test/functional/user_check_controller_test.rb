require 'test_helper'

class UserCheckControllerTest < ActionController::TestCase
  test "should get address" do
    get :address
    assert_response :success
  end

  test "should get account" do
    get :account
    assert_response :success
  end

end
