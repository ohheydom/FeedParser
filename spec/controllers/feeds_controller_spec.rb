require 'spec_helper'

class Feed < ActiveRecord::Base
  def set_feed_order #Allow let method to update feed_order
    if self.feed_order.nil? 
      self.feed_order = Feed.count == 0 ? 1 : (Feed.all.pluck(:feed_order).max + 1)
    end
  end
end

describe FeedsController do
  describe "get #index" do
    let!(:feed) { FactoryGirl.create(:feed, feed_order: 3) }
    let!(:feed_two) { FactoryGirl.create(:feed, title: 'AmazinAvenue', url: 'http://www.amazinavenue.com/rss/current', feed_order: 4) }

    it 'assigns @feed_arr in order' do
      get :index
      expect(assigns(:feed_arr)).to eq([[feed.feed_order, feed.url, feed.id, feed.title],
                                       [feed_two.feed_order, feed_two.url, feed_two.id, feed_two.title]])
    end
  end

end
