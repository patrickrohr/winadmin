class Gameday < ActiveRecord::Base
  belongs_to :league
  has_many :games
end