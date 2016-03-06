source 'http://rubygems.org'

gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'

gem 'sinatra'
gem 'tux'
gem 'bcrypt'
gem 'pry'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'shotgun'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end 

group :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'activerecord-postgresql-adapter'
end
