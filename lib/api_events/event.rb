module ApiEvents
  class Event
    def initialize(record, event)
      @record = record
      @event  = event
    end

    def broadcast!
      binding.pry
    end

    private

    def event_name
      @event_name ||= record.event_name(@event)
    end
  end
end
