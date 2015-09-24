class GamedaySet
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :gamedays
  attr_accessor :sport_id
  attr_accessor :league_id

  validate do |gameday_set|
    gameday_set.gamedays.each do |gameday|
      next if gameday.valid?
      gameday.errors.full_messages.each do |msg|
        errors[:base] << msg
      end
    end
  end


  def gamedays_attributes=(attributes)
    @gamedays ||= []
    attributes.each do |gameday_params|
      obj = Gameday.new(gameday_params)
      @gamedays.push(obj)
    end
  end

  def save
    return false unless valid?
    @gamedays.each do |obj|
      obj.save
    end
  end
end