#Fake Model class that is not saved in database
class RightsGroup
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :id, :name

  @data = ['Admin', 'Redaktor', 'Veranstalter']

  def symbol
    self.name.downcase.to_sym
  end

  def self.all_for_select
    hash = Hash.new
    @data.each_with_index do |format, i|
      hash[format] = i
    end
    return hash
  end

  def self.all
    @data
  end

  def self.find(id)
    object = self.new
    object.id = id
    object.name = @data[id]
    return object
  end

  # To act like an ActiveRecord Model class
  def persisted?
    false
  end
end