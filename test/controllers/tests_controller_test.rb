require 'test_helper'

class TestsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @test = tests(:one)
    @user = users(:one)
    @request.headers['X-User-Email'] = @user.email
    @request.headers['X-User-Token'] = @user.authentication_token
  end

  test "should get index authenticated" do
    get :index,  params: { user_email: @user.email, user_token: @user.authentication_token }
    assert_response :success
    assert_not_nil assigns(:tests)
  end

  test "should get index authenticate by headers" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test" do
    assert_difference('Test.count') do
      post :create, params: {test: { name: @test.name }}
    end

    assert_redirected_to test_path(assigns(:test))
  end

  test "should show test" do
    get :show, params: { id: @test }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @test }
    assert_response :success
  end

  test "should update test" do
    patch :update, params: { id: @test, test: { name: @test.name } }
    assert_redirected_to test_path(assigns(:test))
  end

  test "should destroy test" do
    assert_difference('Test.count', -1) do
      delete :destroy, params: { id: @test }
    end

    assert_redirected_to tests_path
  end
end
