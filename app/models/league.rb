class League < ActiveRecord::Base
  has_many :teams
  has_many :gamedays
  has_many :games
  belongs_to :sport

  before_destroy :check_dependencies # TODO: check if this works, should prevent the league from being destroyed as long as it has teams associated with it.

  def display_name
    "#{number}. Liga"
  end

  def grouped_collection_display_number
    "#{sport.name}: #{number}. Liga"
  end

  private
  def check_dependencies
    sport.errors.add(:base, I18n.t(:league_not_empty, number: self.number)) unless teams.size == 0
    teams.size == 0
  end
end