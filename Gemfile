source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

# authorization
gem 'bcrypt', '~> 3.1.7'
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-vkontakte'
gem 'pundit'

# state_machine
gem 'aasm'

# uploaders
gem 'carrierwave'
gem 'mini_magick'

# pagination
gem 'kaminari'

gem 'activeadmin'
gem 'active_interaction', '~> 4.1'

# database
gem 'counter_culture'
gem 'pg', '~> 1.1'

# model
gem 'active_model_serializers'
gem 'annotate'

gem 'webpacker', '~> 5.0'

gem 'redis', '~> 4.0'

gem 'sidekiq'

gem 'puma', '~> 5.0'
gem 'rails', '~> 6.1.4', '>= 6.1.4.4'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'pry-rails', group: :development

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'web-console', '>= 4.1.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
