class Game < ActiveRecord::Base
  belongs_to :league
  belongs_to :gameday
  
  def team_1
    @team_1 ||= Team.find(team_1_id)
  end

  def team_2
    @team_2 ||= Team.find(team_2_id)
  end
end