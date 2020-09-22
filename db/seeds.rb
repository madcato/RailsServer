# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = User.new
user1.name = "admin"
user1.email = "dani_vela@me.com"
user1.password = "123456"
user1.password_confirmation = "123456"
user1.userType = "admin"
user1.skip_confirmation!
user1.save!