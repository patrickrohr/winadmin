source 'https://rubygems.org'


gem 'rails', '4.1.4'
gem 'pg', '~> 0.17.1'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'tzinfo-data', platforms: [:mingw, :mswin]
gem 'bootstrap-datepicker-rails'
gem 'delocalize'

# https://github.com/leshill/handlebars_assets
gem 'handlebars_assets'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development do
  gem 'meta_request'
end

group :production do
  gem 'rails_12factor', '0.0.2' # for heroku, implements 12factor.net ideas https://github.com/heroku/rails_12factor
  # gem 'rails_stdout_logging' # for heroku, logs to standard out https://github.com/heroku/rails_stdout_logging
  gem 'autoprefixer-rails', '~> 2.1.0' # causes problems just locally??
end