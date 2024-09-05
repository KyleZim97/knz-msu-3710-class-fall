source 'https://rubygems.org'

ruby '3.2.5'


# Core framework
gem 'rails', '~> 7.1.0'  # Use Rails 7.1 for the latest features and security patches.

# Database
gem 'sqlite3', '~> 1.4'  # Chosen for simplicity in development and teaching environments.

# Server
gem 'puma', '~> 5.0'  # High performance web server for Ruby/Rails applications.

# Frontend management
gem 'jsbundling-rails'  # Manages JavaScript with modern bundlers like esbuild, rollup.js.
gem 'cssbundling-rails'  # Manages CSS with tools like Tailwind CSS, Bootstrap.

# Styling
gem 'sass-rails', '>= 6'  # Use Sass for rich CSS with variables and mixins.

# Enhance and speed up HTTP navigation
gem 'turbolinks', '~> 5'  # Makes navigating your web application faster (use with caution as it can interfere with certain JavaScript integrations).

# JSON builders
gem 'jbuilder', '~> 2.7'  # Constructs JSON objects more easily in Rails views.

# Asset management
gem 'sprockets-rails'  # Serves and manages assets in Rails applications.

# Authentication and authorization
gem 'devise'  # Handles authentication with ready-to-use strategies and views.
gem 'pundit'  # Provides a set of helpers to enforce permission policies.

# Background jobs
gem 'sidekiq', '~> 6.0'  # Background processing for Ruby, using Redis for storage.
gem 'redis', '~> 4.0'  # In-memory data structure store, used as database, cache and message broker.


#This ensures that Bundler will use version 2.x of Rubyzip 
#and avoid upgrading to version 3.0+ until you are ready.
gem 'rubyzip', '~> 2.3.0'

group :development, :test do
  gem 'byebug'  # Debugging tool for Ruby.
  gem 'rspec-rails'  # Testing framework for Rails applications.
  gem 'factory_bot_rails'  # Provides a framework for setting up Ruby objects as test data.
  gem 'pry-rails'  # Provides a powerful alternative to the standard IRB shell for Ruby.
end

# Platform-specific gem for handling timezone data in Windows environments.
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Remember to regularly update dependencies to benefit from security patches, bug fixes, and performance improvements.
# Use 'bundle update' to update gems while respecting the specified versions.

