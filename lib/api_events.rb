require "api_events/version"
require "api_events/configuration"
require "api_events/event"
require "api_events/model"
require "api_events/request"
require "api_events/request/endpoint"

require "rails"
require "active_record"

begin
  require "pry"
rescue LoadError
end

module ApiEvents
  class Engine < Rails::Engine
    isolate_namespace ApiEvents
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

ActiveSupport.on_load(:active_record) do
  include ApiEvents::Model
end
