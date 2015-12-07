require 'rails_helper'

describe FeedsController do
  describe 'get #index' do
    let!(:feed) { FactoryGirl.create(:feed) }
    let!(:feed_two) { FactoryGirl.create(:feed, title: 'AmazinAvenue', url: 'http://www.amazinavenue.com/rss/current') }

    it 'assigns @feed_arr in order' do
      get :index
      expect(assigns(:feed_arr)).to eq([FeedsController::FeedMap.new(feed.feed_order, feed.url, feed.id, feed.title),
                                        FeedsController::FeedMap.new(feed_two.feed_order, feed_two.url, feed_two.id, feed_two.title)])
    end
  end
end
