class PublicController < ApplicationController
  skip_authorization_check

  response.headers["X-FRAME-OPTIONS"] = "ALLOW-FROM http://gltv.ch" # allow from IFRAME
  
  layout 'public'
  
  def index
    @sports = Sport.all
  end

  def show
    @sport = Sport.find params[:id]
  end
end
