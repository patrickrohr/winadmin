class GameSet
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :games
  attr_accessor :sport_id
  attr_accessor :league_id

  validate do |game_set|
    game_set.games.each do |game|
      next if game.valid?
      game.errors.full_messages.each do |msg|
        errors[:base] << msg
      end
    end
  end

=begin
  def games_attributes=(attributes)
    @games ||= []
    attributes.each do |game_params|
      raise game_params.inspect
      obj = Game.new(game_params)
      @games.push(obj)
    end
  end
=end
  def games_attributes=(attributes)
    @games ||= []
    attributes.each do |game_params|
      game_id = game_params["id"]
      obj = Game.where(id: game_id).first_or_initialize #in case we're updating here.....
      obj.assign_attributes(game_params)
      @games.push(obj)
    end
  end
  

  def save
    return false unless valid?
    @games.each do |obj|
      obj.save
    end
  end
end