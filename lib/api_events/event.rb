module ApiEvents
  class Event
    attr_reader :record, :event

    NO_ENDPOINTS_ERROR = "There are no registered listeners to broadcast events. See the documentation on how to add listeners (in the gem's initializer)".freeze

    def initialize(record, event)
      @record = record
      @event  = event
    end

    def broadcast!
      ApiEvents::Request.new(event_name, record.json_payload).trigger!(urls: endpoints)
    end

    private

    def endpoints
      ApiEvents.configuration.listeners.presence || raise(NO_ENDPOINTS_ERROR)
    end

    def event_name
      @event_name ||= record.event_name(@event)
    end
  end
end
