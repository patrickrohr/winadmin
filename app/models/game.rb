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

  def team_is_winner?(team_id)
    return team_id == winner_id
  end

  def tie?
    return tie || false
  end

  def create_gamesets
    for i in 1..(league.sport.number_of_sets)
      gamesets.create(number: i)
    end
  end

  def self.add_results(scores)
    scores.each do |game_id, sets|
      game = find game_id
      team_1_sets = 0
      team_2_sets = 0
      sets.each do |set_number, points|
        unless points[0] == "" and points[1] == ""
          points[0] = points[0].to_i
          points[1] = points[1].to_i
        end

        gs = game.gamesets.where(number: set_number).first #returns gameset
        next if gs.nil?
        gs.update_attributes(points_team_1: points[0], points_team_2: points[1])
        if points[0] > points[1]
          team_1_sets += 1
        elsif points [0] < points[1]
          team_2_sets += 1
        elsif points[0] == points[1] and points[0] != "" #makes sure that games without entered results dont show up in rankings
          team_1_sets += 1
          team_2_sets += 1
        end
      end

      if (team_1_sets + team_2_sets) == 0 #skips over no result games
        game.update_attributes(tie: false, winner_id: nil)
        next
      end

      # set winner id and tie for game, most won sets wins, go team
      if team_1_sets > team_2_sets
        game.update_attributes(winner_id: game.team_1_id, tie: false)
      elsif team_1_sets < team_2_sets
        game.update_attributes(winner_id: game.team_2_id, tie: false)
      else
        game.update_attributes(tie: true, winner_id: nil)
      end
    end
  end

  def self.join_left_gamedays
    self.joins('LEFT JOIN gamedays ON games.gameday_id = gamedays.id').order('gamedays.date, games.order')
  end

  def self.join_gamedays
    self.joins(:gameday).order('gamedays.date, games.order')
  end

  # joins gamedays table and checks rights, non admins will only be able to see 
  def self.join_gamedays
    self.joins(:gameday).order('gamedays.date, games.order')
  end

  def gameset_team_points(set_number, team_number)
    gamesets.where(number: i).first.send("points_team_#{team_number}".to_sym)
  end
end