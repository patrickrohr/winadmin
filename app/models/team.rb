class Team < ActiveRecord::Base
  belongs_to :league

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
end