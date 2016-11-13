source "http://rubygems.org"

group :development, :test do
  gem 'puppetlabs_spec_helper', '>= 1.2.0'
  gem 'facter', '>= 1.7.0'
  gem 'rspec-puppet'
  gem 'puppet-lint', '~> 2.0'

  gem 'rspec',     '~> 2.0'   if RUBY_VERSION >= '1.8.7' and RUBY_VERSION < '1.9'
  gem 'rake',      '~> 10.0'  if RUBY_VERSION >= '1.8.7' and RUBY_VERSION < '1.9'
  gem 'json',      '<= 1.8'   if RUBY_VERSION < '2.0.0'
  gem 'json_pure', '<= 2.0.1' if RUBY_VERSION < '2.0.0'
  gem 'metadata-json-lint', '0.0.11'   if RUBY_VERSION < '1.9'
  gem 'metadata-json-lint' if RUBY_VERSION >= '1.9'
end

group :development do
  gem 'beaker-rspec',           :require => false
  gem 'vagrant-wrapper',        :require => false
  gem 'docker-api',             :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', '~> 3.5.0', :require => false
end
