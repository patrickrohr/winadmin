class League < ActiveRecord::Base
  has_many :teams
  belongs_to :sport

  before_destroy :check_dependencies # TODO: check if this works, should prevent the league from being destroyed as long as it has teams associated with it.

  private
  def check_dependencies
    sport.league_error = I18n.t(:league_not_empty) unless teams.size == 0
    teams.size == 0
  end
end