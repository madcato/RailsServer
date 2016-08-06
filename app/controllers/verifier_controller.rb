require 'digest'
require 'base64'

class VerifierController < ApplicationController
  before_action :test_params, only: :check
  
  def check
    @user = User.find_by_id(params[:id])
    if @user
      strToHash = @user.email + @user.authentication_token + params[:rand]
      hash = Digest::SHA512.digest strToHash
      enc   = Base64.strict_encode64(hash)
      if enc == params[:hash] 
        respond({result: :valid})
      else
        respond({result: :invalid})
      end
    else 
      respond({result: :invalid})
    end
  end
  
  def respond(result)
    respond_to do |format|
      format.html { render result }
      format.json { render json: result }
    end
  end
      
private
  def test_params
    [:hash, :id, :rand].each{ |param|
        render(json: {msg: "Parameter '#{param.to_s}' not found"}, status: :bad_request) if params[param].nil?        
    }    
  end
end
