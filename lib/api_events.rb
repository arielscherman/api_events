require "api_events/version"
require "api_events/event"
require "api_events/model"
require "api_events/request"

require "active_record"

begin
  require "pry"
rescue LoadError
end

module ApiEvents
end

ActiveSupport.on_load(:active_record) do
  include ApiEvents::Model
end
