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
    self.user = User.find_by(email: self.email)
    unless self.user.nil?
      if self.user.authenticate(@password)
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
    @session[:user_id] = nil
    self.user = nil
    self.email = nil
    self.password = nil
  end

  def authenticated?
    !@session[:user_id].nil?
  end

  def persisted?
    false
  end


  private
  def save
    @session[:user_id] = self.user.id
  end
end