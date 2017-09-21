# I DON'T THINK THIS IS ACTUALLY USED
# REFER TO game_set.rb
# MARK FOR DELETE
class Gameset < ActiveRecord::Base
  acts_as_paranoid
  belongs_to :game
end