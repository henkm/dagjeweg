require "dagjeweg/version"

# Libraries
require 'open-uri'
require 'net/http'
require 'json'

#  Files
require "dagjeweg/version"
require "dagjeweg/config"
require "dagjeweg/engine" if defined?(Rails) && Rails::VERSION::MAJOR.to_i >= 3
require "dagjeweg/tip"
require "dagjeweg/review"
require "dagjeweg/dagjeweg_error"

# 
# Dagjeweg Module
# 
module Dagjeweg
  API_VERSION = 1


  # returns the version number
  def self.version
    VERSION
  end 

  # sets up configuration
  def self.setup
    yield self
  end


  # For testing purpose only: set the username and password
  # in environment variables to make the tests pass with your test
  # credentials.
  def self.set_credentials_from_environment
    Config.api_key = ENV["DW_API_KEY"]
  end

end