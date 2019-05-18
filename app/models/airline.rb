class Airline < ActiveRecord::Base
  has_many :flights
  has_one_attached :logotype
end
