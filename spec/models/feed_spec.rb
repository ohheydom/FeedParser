require 'spec_helper'

describe Feed do

  it { should respond_to :feed_order }

  describe 'feed_order' do
    let(:new_feed) { FactoryGirl.create(:feed) }
    let(:new_feed_two) { FactoryGirl.create(:feed, title: 'testing12', url: 'http://www.google.com') }

    it 'increments feed_order by highest feed_order' do
      expect(new_feed.feed_order).to eq(1)
      expect(new_feed_two.feed_order).to eq(new_feed.feed_order + 1)
    end
  end

  describe 'Invalid url tester' do
    it 'raises error with bad url' do
      bad_feed = Feed.new(url: 'http://www.badfeedblahblahblahblah.com', title: 'Bad Feed')
      expect { bad_feed.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'raises error with bad url' do
      bad_feed = Feed.new(url: 'htsdfdsftp://www.badf\]]\]]eedblahbllahblah.com', title: 'Bad Feed')
      expect { bad_feed.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'creates a feed with a redirect' do
      feed_with_redirect = Feed.new(url: 'http://metsblog.com/feed', title: 'MetsBlog')
      expect { feed_with_redirect.save! }.to_not raise_error
    end
  end

end
