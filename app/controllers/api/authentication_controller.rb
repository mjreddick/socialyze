module API
  class AuthenticationController < ApplicationController
    respond_to :json

    def sign_in
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        render json: user.api_key
      else
        render json: { alert: "email or password incorrect"},
        status: 422
      end # end if
    end #end sign in
    
  end #end class
end #end Module