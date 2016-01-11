class StaticPagesController < ApplicationController
  skip_authorization_check
  def index
    redirect_to login_path unless user_session.authenticated?
  end

  def help
  end
end
