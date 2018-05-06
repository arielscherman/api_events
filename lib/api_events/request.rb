require "httparty"

class ApiEvents::Request
  include HTTParty

  def initialize(event, payload)
    @event   = event
    @payload = payload
  end

  def trigger!(urls:)
    endpoints(urls).each do |endpoint|
      self.class.post(endpoint.path, params)
    end
  end

  def params
    {
      event: @event,
      data:  @payload
    }
  end

  private

  def endpoints(urls)
    [urls].flatten.map { |url| Endpoint.new(url) }
  end
end

require "api_events/request/endpoint"
