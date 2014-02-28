class Feed < ActiveRecord::Base
  before_create :invalid_url_test, :set_feed_order
  validates :url, uniqueness: true, presence: true
  validates :title, presence: true


  def set_feed_order
    self.feed_order = Feed.count == 0 ? 1 : (Feed.all.pluck(:feed_order).max + 1)
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
