source 'https://rubygems.org'


gem 'rails'
gem 'puma',         '3.9.1'
gem 'sass-rails',   '5.0.6'
gem 'uglifier',     '3.2.0'
gem 'coffee-rails', '4.2.2'
gem 'turbolinks',   '5.0.1'
gem 'jbuilder',     '2.7.0'
gem 'mysql2'
gem 'dotenv-rails'
gem 'rb-readline'

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
gem 'mini_magick', '4.7.0'
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

group :development, :test do
  gem 'byebug',  '9.0.6', platform: :mri
  gem 'rspec-rails', '~> 3.6.0'
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
  gem 'capybara', '~> 2.15.2'
end

group :production do
  gem 'rails_12factor'
  gem 'fog', '1.42'
end

# Windows環境ではtzinfo-dataというgemを含める必要があります
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
