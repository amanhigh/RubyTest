source 'https://rubygems.org'
ruby '2.1.1'
#Nokogiri fails then use NOKOGIRI_USE_SYSTEM_LIBRARIES=1 bundle install

gem 'rails', '4.0.2'

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '3.1.2'

#CSS & Layout
gem 'bootstrap-sass', '2.3.2.0'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'

group :development, :test do
  gem 'sqlite3', '1.3.8'
  gem 'rspec-rails', '2.13.1'
  gem 'factory_girl_rails', '4.2.0'
  gem "zeus", "~> 0.13.4.pre2"
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'faker', '1.1.2'
end

# Use SCSS for stylesheets
gem 'sass-rails', "~>4.0.2"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.1.1'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '4.0.1'

# Use jquery as the JavaScript library
gem 'jquery-rails', '3.0.4'

# Turbolinks makes following links in your web application faster.
# Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '1.1.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '1.0.2'

group :doc do
  #Generating doc using 'sdoc generator=shtml'
  gem 'sdoc', '0.3.20', require: false
end

group :production do
  #Required for heroku.
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end