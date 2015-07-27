class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  add_flash_types :success

  attr_accessor :user_session
  before_filter :load_user_session

  def load_user_session
    self.user_session = Session.new(session)
    self.user_session.load
  end

  def has_rights(*groups)
    return true if check_for_rights *groups
  end

  def user_is(group)
    user_session.rights_group.symbol == group.to_sym
  end


  # Simplifys the uniform create action of most of the controllers
  def create_action(klass, params, redirect_options = {})
    object = klass.new params
    instance_variable_set("@#{klass.model_name.to_s.downcase}", object)
    if object.save
      opt = { action: :index }.merge redirect_options
      redirect_to(opt, { success: I18n.t(:object_created)})
    else
      flash.now.alert = I18n.t :object_create_failed
      render :new
    end
  end

  # Simplifys the uniform destroy action of most of the controllers
  def destroy_action(klass, redirect_options = {})
    opt = { action: :index }.merge redirect_options

    if klass.destroy params[:id]
      redirect_to(opt, { success: I18n.t(:object_deleted) })
    else
      redirect_to(opt, { alert: I18n.t(:object_delete_failed) })
    end
  end

  # Simplifys the uniform update action of most of the controllers
  def update_action(klass, obj_params, redirect_options = {})
    object = klass.find params[:id]
    instance_variable_set("@#{klass.model_name.to_s.downcase}", object)
    if object.update_attributes obj_params then
      opt = { action: :index }.merge redirect_options
      redirect_to(opt, { success: I18n.t(:object_updated) })
    else
      flash.now.alert = I18n.t :object_update_failed
      render :edit
    end
  end


  private
  def check_for_rights(*groups) # :admin, :veranstalter, :redaktor
    groups.include? user_session.rights_group.symbol
  end
end