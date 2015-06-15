module DagjeWeg
  #
  # Simpel extend on the +Rails::Engine+ to add support for a new config section within
  # the environment configs
  #
  # @example default
  #   # /config/environments/development.rb
  # config.dagjeweg.api_key  = "12343465sdfgsadr324"
  #
  class Engine < Rails::Engine
    config.dagjeweg = Docdata::Config
  end
end