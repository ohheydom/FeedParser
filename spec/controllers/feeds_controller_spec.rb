require 'spec_helper'

describe FeedsController do
  describe "get #index" do
    let!(:feed) { FactoryGirl.create(:feed) }
    let!(:feed_two) { FactoryGirl.create(:feed, title: 'AmazinAvenue', url: 'http://www.amazinavenue.com/rss/current') }

    it 'assigns @database_feeds' do
      get :index
      expect(assigns(:database_feeds)).to eq({feed.title => feed.url, feed_two.title => feed_two.url})
    end
  end

end
