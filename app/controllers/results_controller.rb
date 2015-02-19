class ResultsController < ApplicationController

  def show
    @result = TwitterResult.find(params[:id])
  end
  
end
