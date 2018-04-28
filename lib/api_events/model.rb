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

      # Build the event name that will be broadcasted to other apps.
      # This should be overrided if needed.
      #
      # @example Build a name for your Invoice model
      #   invoice.event_name(:created) => "invoice_created"
      #
      # @param [String] event the event to build the name from.
      # @return [String] the event name to broadcast
      def event_name(event)
        "#{self.class.name.underscore}_#{event}"
      end
    end
  end
end
