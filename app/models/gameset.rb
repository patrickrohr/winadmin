class Gameset < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :game
end