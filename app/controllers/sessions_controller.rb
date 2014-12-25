class SessionsController < ApplicationController
  before_filter :redirect, :only => [:new, :create]

  def new
    # @user_session = Session.new
  end

  def create
    self.user_session.create login_params
    if self.user_session.authenticate
      redirect_to root_path
    else
      render :new # add flash message
    end
  end

  def destroy
    self.user_session.destroy
    redirect_to root_path
  end


  private
  def login_params
    params.require(:session).permit(:email, :password)
  end

  def redirect
    redirect_to root_path if user_session.authenticated?
  end
end
