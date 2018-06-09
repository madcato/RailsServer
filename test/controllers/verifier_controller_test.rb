require 'test_helper'

class VerifierControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @user = users(:one)
    @request.headers['X-User-Email'] = @user.email
    @request.headers['X-User-Token'] = @user.authentication_token
    @shared = shared_secrets(:one)
  end
  
  test "should post check" do
    post :check, params: {format: 'json', hash: "0MOM73aNKba5DdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 1, rand: "1234123412341234" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'v'
  end

  test "should fail post check" do
    post :check, params: {format: 'json', hash: "0MOM73aNKbaaBdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 1, rand: "1234123412341234" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'i'
  end
  
  test "should fail post check no user" do
    post :check, params: {format: 'json', hash: "0MOM73aNKba5DdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 5, rand: "1234123412341234" }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'i'
  end
  
  test "should fail post check hash parameter not found" do
    post :check, params: {format: 'json', hashes: "0MOM73aNKba5DdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 1, rand: "1234123412341234" }
    assert_response :bad_request
    response = JSON.parse(@response.body)
    assert_equal response['msg'], "Parameter 'hash' not found"
  end  
  
  test "should fail post check id parameter not found" do
    post :check, params: {format: 'json', hash: "0MOM73aNKba5DdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", rand: "1234123412341234" }
    assert_response :bad_request
    response = JSON.parse(@response.body)
    assert_equal response['msg'], "Parameter 'id' not found"
  end  
  
  test "should fail post check rand parameter not found" do
    post :check, params: {format: 'json', hash: "0MOM73aNKba5DdH8AdLWo04ASZbCyQQ+OLKqk0XZwKuGt1RcTunXQ0DnhVM9z1thkCLkmY/qJIJrjPzgpjUQ2g==", id: 1 }
    assert_response :bad_request
    response = JSON.parse(@response.body)
    assert_equal response['msg'], "Parameter 'rand' not found"
  end  
  
  test "should get shared secret" do
    get :sharedSecret, params: {format: 'json', id: 2}
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['s'], @shared.secret
  end
  
  test "should get a new shared secret" do
    assert_difference('SharedSecret.count') do
      get :sharedSecret, params: {format: 'json', id: 3}
    end
    assert_response :success
    response = JSON.parse(@response.body)
    assert_not_nil response['s']
  end
  
  test "should get shared secret fail id" do
    get :sharedSecret
    assert_response :bad_request
    response = JSON.parse(@response.body)
    assert_equal response['msg'], "Parameter 'id' not found"
  end
  
  test "should get shared secret fail user not found" do
    get :sharedSecret, params: {format: 'json', id: 555}
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'i'
  end
end
