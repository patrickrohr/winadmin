class UsersController < ApplicationController
  #skip_authorization_check
  authorize_resource
  
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      # right now emails are delivered immediately
      # this is considered bad practice
      # TODO: https://devcenter.heroku.com/articles/delayed-job
      UserMailer.new_user(@user).deliver
      redirect_to users_path, success: I18n.t(:object_created)
    else
      flash.now.alert = I18n.t :object_create_failed
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params then
      redirect_to users_path, success: I18n.t(:object_updated)
    else
      flash.now.alert = I18n.t :object_update_failed
      render :edit
    end
  end

  def destroy
    unless user_session.user.id.to_s == params[:id]
      if User.destroy params[:id]
        redirect_to users_path, success: I18n.t(:object_deleted)
        return
      end
    end
    redirect_to users_path, alert: I18n.t(:object_delete_failed)
  end

  def show
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :rights_group_id, :password)
  end
end