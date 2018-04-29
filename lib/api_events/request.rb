require "httparty"

module ApiEvents
  class Request
    include HTTParty

    def initialize(event, payload)
      @event   = event
      @payload = payload
    end

    def trigger!(endpoints:)
      [endpoints].flatten.each do |url|
        self.class.post(url, params)
      end
    end

    def params
      {
        event: @event,
        data:  @payload
      }
    end
  end
end
