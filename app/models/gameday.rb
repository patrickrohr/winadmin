class Gameday < ActiveRecord::Base
  belongs_to :league
  has_many :games, dependent: :destroy
  validates :league_id, presence: true
  validates :location, presence: true
  validates_date :date

  def date=(val)
    #raise val.inspect
    val.gsub!(/\u200E/, '')
    arr = val.split('.')
    val =  # IE and Edge seem to add left to right marks that will have to be stripped
    arr.map! { |n| n.sub(/^[0]+/, '')  }
    val = arr.join('/')
    begin
      date = Date.strptime(val, "%d/%m/%Y")
      write_attribute(:date, date)
    rescue ArgumentError # in case date is invalid / empty
      write_attribute(:date, "")
    end
  end
end