source 'https://rubygems.org'


gem 'rails'
gem 'puma',         '3.12.4'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'
gem 'mysql2'
gem 'dotenv-rails'
gem 'rb-readline'

gem 'google-analytics-rails'

#materialize
gem 'materialize-sass', '~> 1.0.0'
gem 'material_icons'
gem 'jquery-rails', '4.3.1'

#暗号化
gem 'bcrypt', '3.1.12'

#gem 'faker', '1.7.3'
gem 'faker-okinawa'
gem 'will_paginate', '3.1.6'
gem 'will_paginate-materialize', git: 'https://github.com/mldoscar/will_paginate-materialize', branch: 'master'
gem 'kaminari'
gem 'carrierwave', '1.2.2'
gem 'mini_magick', '4.9.4'
gem 'bootsnap', require: false

# google book api
gem 'googlebooks', '~> 0.0.9'

# 検索
gem 'search_cop'

gem 'seed_dump'

gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem "omniauth-rails_csrf_protection"

gem "lazyload-rails"

group :development, :test do
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'rspec-rails'
  gem "factory_bot_rails", "~> 4.10.0"
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest',                 '5.10.3'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
  gem 'capybara', '~> 3.25.0'
  gem 'webdrivers'
  gem 'launchy', '~> 2.4.3'
  gem 'guard-rspec', require: false
end

group :production do
  gem 'rails_12factor'
  gem 'fog', '1.42'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
