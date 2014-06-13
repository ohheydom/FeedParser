require 'no_response_url'

class UrlTest
  attr_reader :uri

  def initialize(url)
    @uri = URI(url)
  rescue
    @uri = ''
  end

  def uri_path
    uri.path.empty? ? '/' : uri.path
  end

  def request
    @_request ||= Net::HTTP.new(uri.host, uri.port)
  end

  def response
    request.request_head(uri_path)
  rescue
    return NoResponseUrl.new
  end

  def code
    response.code.to_i
  end

  def valid?
    code == 200 || code.to_s[0] == '3'
  end
end
