source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.0.rc1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'carrierwave'
gem 'rmagick'
gem 'protected_attributes'
gem 'rails-observers'
gem 'actionpack-page_caching'
gem 'actionpack-action_caching'
gem 'activerecord-deprecated_finders'
gem 'thinking-sphinx', '3.0.0'
gem "jquery-ui-rails"
gem "will_paginate"
gem 'sidekiq'
gem 'mini_magick'
gem 'geocoder'
gem 'whenever', require: false

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0.rc1'
  gem 'coffee-rails', '~> 4.0.0.rc1'
  gem 'uglifier', '>= 1.3.0'
  
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

end

gem 'jquery-rails'
gem 'best_in_place', github: 'bernat/best_in_place'

# To use ActiveModel has_secure_password
 gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'rspec-rails', :group => [:test, :development]
gem 'database_cleaner', :group => [:test, :development]
group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'rb-fsevent'
end