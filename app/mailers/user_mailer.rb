class UserMailer < ActionMailer::Base
  default from: "support@gltv.ch"

  def new_user(user)
    @user = user
    mail(to: @user.email, subject: I18n.t(:new_user_subject))
  end

  def forgot_password(user)
    @user = user
    mail(to: @user.email, subject: I18n.t(:forgot_password_subject))
  end
end
