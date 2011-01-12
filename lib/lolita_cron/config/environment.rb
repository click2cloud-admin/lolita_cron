ENV['DAEMON_ENV'] ||= 'development'

# Boot Rails
ENV["RAILS_ENV"] ||= 'development'
require File.expand_path(File.join(File.dirname(__FILE__),'..','..','..','..','..','..','config','boot'))

# Load rake tasks, so we can use them in our cron tasks
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'tasks/rails'

# Boot up
require File.join(File.dirname(__FILE__), 'boot')

# Auto-require default libraries and those for the current Rails environment.
Bundler.require :default, DaemonKit.env

DaemonKit::Initializer.run do |config|
  config.daemon_name = "lolita_cron"
  config.force_kill_wait = 30
  Rails.logger.level = Logger::Severity::UNKNOWN
end
