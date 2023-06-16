# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "slim"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

gem "aws-sdk-ssm", "~> 1"

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rspec"
  gem "rspec-rails"
end

group :development, :ci do
  gem "rubocop", "~> 1.44"
  gem "rubocop-performance", "~> 1.15"
  gem "rubocop-rails", "~> 2.17"
  gem "rubocop-rspec", "~> 2.18"
end

group :ci do
  gem "brakeman"
  gem "bundler-audit"
end
