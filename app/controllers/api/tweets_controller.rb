module API
  class TweetsController < ApplicationController
    # before_action :restrict_access
    # before_action :load_user, except :index

    def index 
      render json: Tweet.all
    end


    private

    def tweet_params
      params.require(:tweet).permit(:tweet_text, :twitter_account, :access_token)
    end

    def restrict_access
      api_key = APIKey.find_by(access_token: params[:access_token])
      render plain: "You are not authorized to view this page", status: 401 unless api_key
    end

    def load_user
      user = User.find_by_access_token(params[:access_token])
    end

  end # end class
end #end module