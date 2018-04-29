module ApiEvents
  class Event
    attr_reader :record, :event

    def initialize(record, event)
      @record = record
      @event  = event
    end

    def broadcast!
      endpoints = ApiEvents.configuration.listeners
      ApiEvents::Request.new(event_name, record.json_payload).trigger!(endpoints: endpoints)
    end

    private

    def event_name
      @event_name ||= record.event_name(@event)
    end
  end
end
