class Sport < ActiveRecord::Base
  has_many :leagues

  before_validation :adjust_number_of_leagues


  def number_of_leagues
    @number_of_leagues ||= leagues.size
  end

  def number_of_leagues=(value)
    @number_of_leagues = value.to_i #validations TODO
  end

  def adjust_number_of_leagues
    #check if value is smaller or bigger than number of leagues
    if number_of_leagues >= leagues.size
      #increase leagues accordingly
      for i in (leagues.size + 1)..number_of_leagues
        leagues.create(number: i)
      end
    else
      #decrease leagues accordingly
      for i in (number_of_leagues + 1)..leagues.size
        league = leagues.where(number: i).first
        league.destroy
      end
    end
  end
end