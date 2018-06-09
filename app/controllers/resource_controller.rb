class ResourceController < ApplicationController
  before_action :test_params_check
  before_action :test_merchant, only: :userData
  before_action :test_client, only: :merchantData
  
  def userData
    @user = User.find_by_id(params[:id])
    if @user && @user.client? && @user.is_valid?
      respond({u: {n: @user.name, p: @user.photo}})
    else 
      respond({r: :i})
    end
  end

  def merchantData
    @user = User.find_by_id(params[:id])
    if @user && @user.merchant? && @user.is_valid?
      respond({u: {n: @user.name, p: @user.photo}})
    else 
      respond({r: :i})
    end
  end
  
private
  def test_params_check
    [:id].each{ |param|
      render(json: {msg: "Parameter '#{param.to_s}' not found"}, status: :bad_request) if params[param].nil?        
    }    
  end
  
  def test_merchant
    render(json: {msg: "Invalid user type. This method must be called by a merchant user"}, status: :bad_request) unless current_user.merchant?
  end
  
  def test_client
    render(json: {msg: "Invalid user type. This method must be called by a client user"}, status: :bad_request) unless current_user.client?
  end
end
