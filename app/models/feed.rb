class Feed < ActiveRecord::Base
  before_create :invalid_url_test, :set_feed_order
  before_update :invalid_url_test
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
      errors.add(:url, "The url doesn't appear to be valid")
      return false
    end

    if response.code.to_i != 200 && response.code[0] != '3'
      errors.add(:url, "The url doesn't appear to be valid")
      return false
    end
  end
end
