require 'test_helper'

class PlansControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get all" do
    get :all
    assert_response :success
  end

  test "should get daily" do
    get :daily
    assert_response :success
  end

  test "should get weekly" do
    get :weekly
    assert_response :success
  end

  test "should get weekend" do
    get :weekend
    assert_response :success
  end

end
