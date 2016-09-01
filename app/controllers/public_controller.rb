class PublicController < ApplicationController
  skip_authorization_check
  
  layout 'public'
  
  def index
    #response.headers["X-FRAME-OPTIONS"] = "ALLOW-FROM http://gltv.ch" # allow from IFRAME
    @sports = Sport.all
  end

  def show
    response.headers.except! 'X-Frame-Options' # allow from IFRAME
    @sport = Sport.find params[:id]
  end
end
