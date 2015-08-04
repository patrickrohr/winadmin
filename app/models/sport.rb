class Sport < ActiveRecord::Base
  has_many :leagues

  before_validation :adjust_number_of_leagues
  after_save :save_new_leagues
  before_destroy :try_to_delete_leagues

  class << self
    attr_accessor :selected # for sport filter drop down
  end

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
        leagues.new(number: i)
      end
    else
      #decrease leagues accordingly
      for i in (number_of_leagues + 1)..leagues.size
        league = leagues.where(number: i).first
        league.destroy
      end
    end
  end

  # New leagues cannot be saved as long as the parent object (sport) is not saved
  def save_new_leagues
    leagues.each { |l| l.save }
  end

  # tries to delete all associated leagues before destroying a sport
  def try_to_delete_leagues
    self.number_of_leagues = 0
    adjust_number_of_leagues
    return errors.size == 0
  end
end