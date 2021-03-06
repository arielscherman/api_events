module ApiEvents
  module Model
    # This class is responsible of loading the class attributes required by our gem, and adding the callbacks on the AR model too.
    class Config
      EVENT_CALLBACKS = { 
        created:   :after_create,
        updated:   :after_update,
        destroyed: :after_destroy
      }

      def initialize(model_class)
        @model_class = model_class
      end

      # Setup callbacks and required side methods to broadcast events on AR callbacks.
      #
      # @param [Hash] options the options to define the events.
      # @option options [Array, Symbol] :on ([:created, :updated, :destroyed]) events to broadcast
      def setup(options = {})
        setup_events(options)
        setup_broadcast
      end

      def setup_events(options = {})
        @model_class.class_attribute :broadcast_events
        @model_class.broadcast_events = [options[:on]].flatten.compact.presence || all_events
      end

      # For each specified event, add the right "after" callback.
      def setup_broadcast
        @model_class.broadcast_events.each { |event| add_callback_to_model(event) }
      end

      def add_callback_to_model(event)
        @model_class.send(callback_for_event(event)) do |record|
          record.broadcast_event!(event)
        end 
      end

      def all_events
        EVENT_CALLBACKS.keys
      end

      def callback_for_event(event)
        EVENT_CALLBACKS[event]
      end
    end
  end
end
