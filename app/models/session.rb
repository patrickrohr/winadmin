class Session
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email, :user
  attr_writer :password

  def initialize(session)
     @session = session
  end

  def create(hash)
    self.email = hash[:email]
    self.password = hash[:password]
  end

  def authenticate
    user = User.find_by(email: self.email)
    unless user.nil?
      #raise user.inspect
      if self.user = user.authenticate(@password)
        save
        return true
      end
    end
    false
  end

  def load
    unless @session[:user_id].nil?
      self.user = User.find(@session[:user_id])
      return true
      # reset_session # counter measures against session fixation
      # sess.save
    end
    false
  end

  def destroy
    #@session[:user_id] = nil
    @session.delete(:user_id)
  end

  def authenticated?
    !@session[:user_id].nil?
  end

  def persisted?
    false
  end


  def set(key, value)
    return false if key.to_sym == :user_id
    @session[key.to_sym] = value
  end

  def get(key)
    @session[key]
  end

  def has_key?(key)
    @session.has_key? key
  end


  private
  def save
    @session[:user_id] = self.user.id
  end
end