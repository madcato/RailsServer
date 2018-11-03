# RailsServer

Generic boilerplate server made in RubyOnRails to start new projects.

## Install

1. Install rvm

2. Install Ruby with rvm

		$ rvm install ruby-2.3.8

3. Install Rails 5.2

4. Git clone this project

5. Enter in project dir an update gems with:

		$ bundle update


## This project contains

- Devise (for user authentication and registering)
- simple\_token\_authentication (for token authentication)


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