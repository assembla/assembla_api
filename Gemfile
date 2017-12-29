source 'https://rubygems.org'

gemspec

group :guard do
  gem 'rb-fsevent',   :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spinach'
end

group :development do
  gem 'activesupport', '~> 4.1.11'
  gem 'rake'
  gem 'rspec'
  gem 'spinach'
  gem 'webmock'
  gem 'vcr'
  gem 'yard', '~> 0.9.11'
end

group :metrics do
  gem 'coveralls'
  gem 'simplecov'
  gem 'yardstick'
  gem 'reek'
  gem 'roodi'
end
