require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_destroy
    authentication = Authentication.first
    delete :destroy, :id => authentication
    assert_redirected_to authentications_url
    assert !Authentication.exists?(authentication.id)
  end
end
