class Feed < ActiveRecord::Base
  before_save :feed_order
  before_create :invalid_url_test


  def feed_order
    self.feed_order = self.id
  end

  def invalid_url_test
    uri = URI(self.url)
    request = Net::HTTP.new(uri.host, uri.port)
    begin
    response = request.request_head(uri.path.empty? ? '/' : uri.path)
    rescue
      return false
    end
    return false unless response.code.to_i == 200

  end
end
