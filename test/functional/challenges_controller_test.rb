require 'test_helper'

class ChallengesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get accept" do
    get :accept
    assert_response :success
  end

  test "should get leave" do
    get :leave
    assert_response :success
  end

end
