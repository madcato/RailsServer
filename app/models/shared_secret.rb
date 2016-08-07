require 'digest'
require 'base64'

class SharedSecret < ActiveRecord::Base
  has_one :user, foreign_key: :id1
  has_one :user, foreign_key: :id2
  
  after_initialize do |user|
    if self.secret.nil?
      # Generate secret
      random = rand(10000000000)
      str = "#{id1}#{id2}#{random}"
      hash = Digest::SHA512.digest str
      self.secret = Base64.strict_encode64(hash)
    end
  end
end
