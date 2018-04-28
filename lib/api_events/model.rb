require "api_events/model/config"

module ApiEvents
  module Model
    def self.included(base)
      base.send :extend,  ClassMethods
      base.send :include, InstanceMethods
    end

    module ClassMethods
      def broadcast(options = {})
        api_events.setup(options)
      end

      def api_events
        ::ApiEvents::Model::Config.new(self)
      end
    end

    module InstanceMethods
      def broadcast_event!(event)
        ApiEvents::Event.new(self, event).trigger!
      end
    end
  end
end
