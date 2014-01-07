class Precinct < ActiveRecord::Base
  attr_accessible :middlename, :name, :ovd_house, :ovd, :ovd_street, :ovd_telnumber, :ovd_town, :photo, :surname

  has_many :precinct_houses
end
