# This class is responsible to return the right endpoint urls from a
# base url (adding the right suffix path).
class ApiEvents::Request::Endpoint
  ENDPOINT_SUFFIX = "api/events".freeze

  def initialize(url)
    @url = url
  end

  def path
    @url = @url + "/" unless @url.end_with?("/")
    "#{@url}#{ENDPOINT_SUFFIX}"
  end
end
