module ApiEvents
  class Event
    def initialize(record, event)
      @record = record
      @event  = event
    end

    def trigger!
      binding.pry
    end
  end
end
