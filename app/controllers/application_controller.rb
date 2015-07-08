class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  attr_accessor :user_session
  before_filter :load_user_session

  def load_user_session
    self.user_session = Session.new(session)
    self.user_session.load
  end

  def has_rights(*groups)
    if check_for_rights *groups
      
  end

  def user_is(group)
    user_session.rights_group.symbol == group.to_sym
  end

  private
  def check_for_rights(*groups) # :admin, :veranstalter, :redaktor
    groups.include? user_session.rights_group.symbol
  end
end
