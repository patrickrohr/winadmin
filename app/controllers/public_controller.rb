class PublicController < ApplicationController
  skip_authorization_check
  
  layout 'public'
  
  def index
    @sports = Sport.all
  end

  def show
    @sport = Sport.find params[:id]
  end
end
