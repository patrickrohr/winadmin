class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :rights_group_id, inclusion: { in: 0..2 }

  before_validation { generate_password if self.password.nil? }

  def rights_group
    @rights_group ||= RightsGroup.find rights_group_id
  end

  def generate_password
    #self.password = "test"
    self.password = SecureRandom.urlsafe_base64(8) # TODO: DO NOT FORGET ABOUT THIS

    @password_new = self.password #since only a hash will be saved in the db
  end

  def password_new
    return @password_new
  end
end
