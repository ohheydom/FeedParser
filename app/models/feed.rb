class Feed < ActiveRecord::Base
  before_create :set_feed_order
  validates :url, uniqueness: true, presence: true, valid_url: true
  validates :title, presence: true

  def set_feed_order
    self.feed_order = Feed.count == 0 ? 1 : (Feed.all.pluck(:feed_order).max + 1)
  end
end
