source 'https://rubygems.org'
ruby                            '2.3.1'

gem 'rails',                    '4.2.7.1'                    # Basic
gem 'bcrypt',                   '3.1.7'                    # bcrypt Hash
gem 'carrierwave',              '0.10.0'                   # Image handling
gem 'mini_magick',              '3.8.0'                    # Image handling
gem 'fog',                      '1.36.0'                   # Image handling
gem 'will_paginate',            '3.0.7'                    # Pagination
gem 'bootstrap-will_paginate',  '0.0.10'                   # Pagination
gem 'bootstrap-sass',           '3.2.0.0'                  # Bootstrap
gem 'sprockets',                '3.7.0'                    # Basic
gem 'sass-rails',               '5.0.6'                    # Basic
gem 'uglifier',                 '2.5.3'                    # Basic
gem 'coffee-rails',             '4.1.0'                    # Basic
gem 'jquery-rails',             '4.0.4'                    # Basic
gem 'turbolinks',               '2.3.0'                    # Basic
gem 'jbuilder',                 '2.2.3'                    # Basic
gem 'sdoc',                     '0.4.0', group: :doc       # Basic
gem 'pg',                       '0.17.1'                   # Basic

group :development, :test do
  gem 'byebug',                 '3.4.0'                    # Basic
  gem 'spring-commands-rspec'
  gem 'rspec-rails',            '~> 3.4'                   # Testing
  gem 'database_cleaner',       '~> 1.5'                   # Testing
  gem 'factory_girl_rails',     '~> 4.5.0'                 # Testing
  gem 'capybara',               '~> 2.5'                   # Testing
  gem 'faker'                                              # Testing
end

group :development do
  gem 'web-console',            '~> 2.0'                   # Basic
  gem 'guard-rspec',            require: false
end

group :test do
  gem 'shoulda-matchers',       '~> 3.0', require: false   # Testing
end

group :production do
  gem 'rails_12factor',         '0.0.2'                    # Basic
  gem 'puma',                   '3.1.0'                    # Puma production-ready web server
end
