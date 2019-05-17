class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
         
         
  # UserType value
  CLIENT = 0
  MERCHANT = 1
  ADMIN = 2
  
  def client?
    return self.userType == User::CLIENT
  end
  
  def merchant?
    return self.userType == User::MERCHANT
  end
  
  def admin?
    return self.userType == User::ADMIN
  end
  
  def is_valid?
    return !(self.name.nil? || self.photo.nil?)
  end
end
