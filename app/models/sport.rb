class Sport < ActiveRecord::Base
  has_many :leagues

  validate :league_errors?
  attr_accessor :league_error # for league dependency errors

  def number_of_leagues
    leagues.size
  end

  def number_of_leagues=(value)
    #check if value is smaller or bigger than number of leagues
    value = value.to_i # TODO: validations
    if value >= number_of_leagues
      #increase leagues accordingly
      for i in (number_of_leagues + 1)..value
        leagues.create(number: i)
      end
    else
      #decrease leagues accordingly
      for i in (value + 1)..number_of_leagues
        league = leagues.where(number: i).first
        league.destroy
      end
    end
  end

  private
  def league_errors?
    errors.add(:base, league_error) if league_error
    league_error = ''
  end
end