require 'digest'
require 'base64'

class VerifierController < ApplicationController
  before_action :test_params_check, only: :check
  before_action :test_params_sharedSecret, only: :sharedSecret
  
  def check
    @user = User.find_by_id(params[:id])
    if @user
      strToHash = @user.email + @user.authentication_token + params[:rand]
      hash = Digest::SHA512.digest strToHash
      enc   = Base64.strict_encode64(hash)
      if enc == params[:hash] 
        respond({r: :v})
      else
        respond({r: :i})
      end
    else 
      respond({r: :i})
    end
  end

  def sharedSecret
    @user = User.find_by_id(params[:id])
    if @user
      @sharedSecret = SharedSecret.find_by({id1: current_user, id2: @user} ) || SharedSecret.find_by({id2: current_user.id, id1: @user.id} )
      if @sharedSecret
        respond({s: @sharedSecret.secret})
      else
        # Create and respond new secret
        @sharedSecret = SharedSecret.new({id1: current_user, id2: @user})
        if @sharedSecret.save
          respond({s: @sharedSecret.secret})
        end
      end
    else
      respond({r: :i})
    end
  end
 
private
  def test_params_check
    [:hash, :id, :rand].each{ |param|
        render(json: {msg: "Parameter '#{param.to_s}' not found"}, status: :bad_request) if params[param].nil?        
    }    
  end
  def test_params_sharedSecret
    [:id].each{ |param|
        render(json: {msg: "Parameter '#{param.to_s}' not found"}, status: :bad_request) if params[param].nil?        
    }    
  end
end
