class Flight < ActiveRecord::Base
  belongs_to :airline, required: true
  
  def name
    "#{self.origin} - #{self.destination} (#{self.code})"
  end
end
