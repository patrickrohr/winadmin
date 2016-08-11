require 'pwgen.rb'

module ActiveModel::SecurePassword::InstanceMethodsOnActivation
  def generate_readable_password(length)
    pwgen = PasswordGenerator.new
    pwgen.generate(length)
  end
end