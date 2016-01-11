class SessionsController < ApplicationController
  skip_authorization_check
  def new
    # Is defined in application_controller
    # @user_session = Session.new session
  end

  def create
    self.user_session.create login_params
    if self.user_session.authenticate
      redirect_to root_path
    else
      render :new, alert: I18n.t(:login_failed)
    end
  end

  def destroy
    self.user_session.destroy
    redirect_to root_path
  end

  def forgot_password
  end

  def password_reset
    # Create new password for user
    user = User.find_by(email: params[:session][:email])
    unless user.nil?
      user.generate_password
      if user.save
        # Send it to user
        UserMailer.forgot_password(user).deliver
      end
    end
    redirect_to root_path, success: I18n.t(:check_your_email)
  end


  private
  def login_params
    params.require(:session).permit(:email, :password)
  end

  def redirect
    redirect_to root_path if user_session.authenticated?
  end
end
