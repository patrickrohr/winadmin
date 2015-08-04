class Game < ActiveRecord::Base
  belongs_to :league
  belongs_to :gameday
  has_many :gamesets, dependent: :destroy

  after_create :create_gamesets
  
  def team_1
    @team_1 ||= Team.find(team_1_id)
  end

  def team_2
    @team_2 ||= Team.find(team_2_id)
  end

  def create_gamesets
    for i in 1..(league.sport.number_of_sets)
      gamesets.create(number: i)
    end
  end

  def self.add_results(scores)
    scores.each do |game_id, sets|
      game = find game_id
        sets.each do |set_number, points|
          gs = game.gamesets.where(number: set_number).first
          next if gs.nil?
          gs.points_team_1 = points[0]
          gs.points_team_2 = points[1]
          gs.save
        end
    end
  end

  def self.join_left_gamedays
    self.joins('LEFT JOIN gamedays ON games.gameday_id = gamedays.id').order('gamedays.date')
  end

  def self.join_gamedays
    self.joins(:gameday).order('gamedays.date')
  end
end