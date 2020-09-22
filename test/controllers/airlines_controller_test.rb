require 'test_helper'

class AirlinesControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def auth
    @request.headers['X-User-Email'] = @user.email
    @request.headers['X-User-Token'] = @user.authentication_token
  end

  setup do
    @airline = airlines(:one)
    @user = users(:one)
    auth
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create airline" do
    assert_difference('Airline.count') do
      post :create, params: { airline: { name: @airline.name } }
    end

    assert_redirected_to airline_url(Airline.last)
  end

  test "should show airline" do
    get :show, params: { id: @airline } 
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @airline }
    assert_response :success
  end

  test "should update airline" do
    patch :update, params: { id: @airline, airline: { name: @airline.name } }
    assert_redirected_to airline_url(@airline)
  end

  test "should destroy airline" do
    assert_difference('Airline.count', -1) do
      delete :destroy, params: { id: @airline }
    end
    assert_redirected_to airlines_url
  end
end
