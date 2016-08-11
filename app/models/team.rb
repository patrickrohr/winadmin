class Team < ActiveRecord::Base
  belongs_to :league

  validates :name, presence: true
  validates :number, presence: true, numericality: { only_integer: true }, uniqueness: { scope: :league_id, message: "muss innerhalb der Liga eindeutig sein."}

  attr_accessor :sport_id

  def sport
    unless league.nil?
      @sport ||= league.sport
    else
      nil
    end
  end

  def sport_id
    unless sport.nil?
      sport.id
    else
      nil
    end
  end

  def self.order_ranking

  end

  #def game_count
  #  Game.joins(:gameday).where('gamedays.date<=?', Date.today).where('(games.team_1_id=? OR games.team_2_id=?) AND (games.tie=? OR games.winner_id IS NOT NULL)', id, id, true).size
  #end
end