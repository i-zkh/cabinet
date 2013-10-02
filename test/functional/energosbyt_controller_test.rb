require 'test_helper'

class EnergosbytControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get xls" do
    get :xls
    assert_response :success
  end

end
