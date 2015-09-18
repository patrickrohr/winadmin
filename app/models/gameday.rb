class Gameday < ActiveRecord::Base
  belongs_to :league
  has_many :games
  validates :league_id, presence: true
end