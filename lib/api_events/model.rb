require "api_events/model/config"

module ApiEvents
  module Model
    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods
      def broadcast(options = {})
        api_events.setup(options)
      end

      def api_events
        ::ApiEvents::Model::Config.new(self)
      end
    end
  end
end
