# RailsServer

Generic boilerplate server made in RubyOnRails to start new projects.

## Install

1. Install rvm

2. Install Ruby with rvm

		$ rvm install ruby-2.3.8

3. Install Rails 5.2

4. Git clone this project

5. Isntall bundle

		$ gem install bundle

6. Enter in project dir an update gems with:

		$ bundle update

7. Migrate db
	
		$ rake db:migrate

8. Seed database

		$ rake db:seed

    This will create and admin user (dani\_vela@me.com , password: 123456)

## This project contains

- [Devise (for user authentication and registering)](https://github.com/plataformatec/devise)
- [simple\_token\_authentication (for token authentication)](https://github.com/gonzalo-bulnes/simple_token_authentication)
- [rails\_admin (db administration)](https://github.com/sferik/rails_admin)
- [cancancan (authorization management)](https://github.com/CanCanCommunity/cancancan)

## New users

Create new user with [http://localhost:3000/users/sign_up](http://localhost:3000/users/sign_up)

## Instructions to change the name of the project

Change all ocurrences of "RailsServer" string to your project name

This string appears in this files:
- app/views/layouts/application.html.erb
- config/appication.rb
- config/initializers/session\_store.rb




## Gems
- https://github.com/hothero/awesome-rails-gem
- https://dev.to/rob__race/27-gems-i-use-in-almost-every-project