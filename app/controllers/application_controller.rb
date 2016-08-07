class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  # This line is needed to send curl login request like
  #     curl -H 'Content-Type: application/json' 
  #     -H 'Accept: application/json' 
  #     -X POST http://localhost:3000/users/sign_in 
  #     -d "{\"user\":{\"email\":\"dani_vela@me.com\",\"password\":\"123456\"}}" 
  #     -c cookie
  respond_to :html, :json 
  acts_as_token_authentication_handler_for User
  
private
  def respond(result)
    respond_to do |format|
      format.html { render result }
      format.json { render json: result }
    end
  end  
end
