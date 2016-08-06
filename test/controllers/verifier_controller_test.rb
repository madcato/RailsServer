require 'test_helper'

class VerifierControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @user = users(:one)
    @request.headers['X-User-Email'] = @user.email
    @request.headers['X-User-Token'] = @user.authentication_token
  end
  
  test "should post check" do
    post :check, {format: 'json', hash: "0MOM73aNKba5DdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 1, rand: "1234123412341234" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['result'], 'valid'
  end

  test "should fail post check" do
    post :check, {format: 'json', hash: "0MOM73aNKbaaBdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 1, rand: "1234123412341234" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['result'], 'invalid'
  end
  
  test "should fail post check no user" do
    post :check, {format: 'json', hash: "0MOM73aNKba5DdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 5, rand: "1234123412341234" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['result'], 'invalid'
  end  
end
