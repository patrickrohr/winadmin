class Game < ActiveRecord::Base
  belongs_to :league
  belongs_to :gameday
  
  def team_1
    @team_1 ||= Team.find(team_1_id)
  end

  def team_2
    @team_2 ||= Team.find(team_2_id)
  end

  def self.join_left_gamedays
    self.joins('LEFT JOIN gamedays ON games.gameday_id = gamedays.id').order('gamedays.date')
  end
end