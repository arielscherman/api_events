module ApiEvents
  class Event
    attr_reader :record, :event

    def initialize(record, event)
      @record = record
      @event  = event
    end

    def broadcast!
      # TODO: we should send a request to each listener.
      ApiEvents::Request.new(event_name, record.json_payload).trigger!(endpoints: "http://localhost:3000/")
    end

    private

    def event_name
      @event_name ||= record.event_name(@event)
    end
  end
end
