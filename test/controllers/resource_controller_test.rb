require 'test_helper'

class ResourceControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @clientUser = users(:one)
    @otherClientUser = users(:two)
    @merchantUser = users(:three)
    @otherMerchantUser = users(:four)
  end
  
  test "should get userData" do
    @request.headers['X-User-Email'] = @merchantUser.email
    @request.headers['X-User-Token'] = @merchantUser.authentication_token
    get :userData, params: { format: :json, id: @clientUser }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_not_nil response['u']
    userData = response['u']
    assert_equal userData['n'], @clientUser.name
    assert_equal userData['p'], @clientUser.photo
  end

  test "should fail get userData" do
    @request.headers['X-User-Email'] = @clientUser.email
    @request.headers['X-User-Token'] = @clientUser.authentication_token
    get :userData, params: { id: @clientUser }
    assert_response :bad_request
  end

  test "should fail a client to get another client userData" do
    @request.headers['X-User-Email'] = @clientUser.email
    @request.headers['X-User-Token'] = @clientUser.authentication_token
    get :merchantData, params: { format: :json, id: @otherClientUser }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'i'
  end
  
  test "should fail a client to get an invalid userData" do
    @request.headers['X-User-Email'] = @clientUser.email
    @request.headers['X-User-Token'] = @clientUser.authentication_token
    get :merchantData, params: { format: :json, id: users(:six) }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'i'
  end
  
  test "should get merchantData" do
    @request.headers['X-User-Email'] = @clientUser.email
    @request.headers['X-User-Token'] = @clientUser.authentication_token
    get :merchantData, params: { format: :json, id: @merchantUser }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_not_nil response['u']
    userData = response['u']
    assert_equal userData['n'], @merchantUser.name
    assert_equal userData['p'], @merchantUser.photo
  end

  test "should fail get merchantData" do
    @request.headers['X-User-Email'] = @merchantUser.email
    @request.headers['X-User-Token'] = @merchantUser.authentication_token
    get :merchantData, params: { id: @merchantUser }
    assert_response :bad_request
  end

  test "should fail a merchant to get another merchant userData" do
    @request.headers['X-User-Email'] = @merchantUser.email
    @request.headers['X-User-Token'] = @merchantUser.authentication_token
    get :userData, params: { format: :json, id: @otherMerchantUser }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'i'
  end
  
  test "should fail a merchant to get an invalid userData" do
    @request.headers['X-User-Email'] = @merchantUser.email
    @request.headers['X-User-Token'] = @merchantUser.authentication_token
    get :userData, params: { format: :json, id: users(:five) }
    assert_response :success
    response = JSON.parse(@response.body)
    assert_equal response['r'], 'i'
  end
end
