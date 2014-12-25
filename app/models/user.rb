class User < ActiveRecord::Base
  has_secure_password

  # TODO: validations

  before_validation { generate_password if self.password.nil? }

  def rights_group
    @rights_group ||= RightsGroup.find rights_group_id
  end

  def generate_password
    self.password = "test"
    # self.password = SecureRandom.urlsafe_base64(6) # TODO: DO NOT FORGET ABOUT THIS
  end
end
