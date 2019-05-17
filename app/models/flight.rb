class Flight < ActiveRecord::Base
  belongs_to :airline, required: true
end
