require 'test_helper'

class FlightsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  def auth
    @request.headers['X-User-Email'] = @user.email
    @request.headers['X-User-Token'] = @user.authentication_token
  end

  setup do
    @flight = flights(:one)
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

  test "should create flight" do
    assert_difference('Flight.count') do
      post :create, params: { flight: { code: @flight.code, destination: @flight.destination, origin: @flight.origin}, airline: @airline }
    end
    assert_redirected_to flight_url(Flight.last)
  end

  test "should show flight" do
    get :show, params: { id: @flight }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @flight }
    assert_response :success
  end

  test "should update flight" do
    patch :update, params: { id: @flight, flight: { code: @flight.code, destination: @flight.destination, origin: @flight.origin } }
    assert_response :success
  end

  test "should destroy flight" do
    assert_difference('Flight.count', -1) do
      delete :destroy, params: { id: @flight }
    end
    assert_redirected_to flights_url
  end
end
