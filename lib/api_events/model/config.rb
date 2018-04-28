module ApiEvents
  module Model
    class Config
      def initialize(model_class)
        @model_class = model_class
      end

      def setup(options = {})
        setup_broadcast(options)
      end

      def setup_broadcast(options = {})
        @model_class.class_attribute :broadcast_events
        @model_class.broadcast_events = Array.wrap(options[:on]).presence || %i(created updated deleted)
      end
    end
  end
end
