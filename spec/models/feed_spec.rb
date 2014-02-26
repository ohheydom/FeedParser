require 'spec_helper'

describe Feed do
  let(:new_feed) { FactoryGirl.create(:feed) }
  let(:new_feed_two) { FactoryGirl.create(:feed, title: 'testing12') }
  subject { new_feed }
  it { should respond_to :feed_order }

  describe "feed_order" do
    it "creates a feed order equal to the integer" do
      expect(new_feed.feed_order).to eq(new_feed.id)
      expect(new_feed_two.feed_order).to eq(new_feed_two.id)
    end
  end

  describe "Invalid url tester" do
    it "raises error with bad url" do
      bad_feed = Feed.new(url: 'http://www.badfeedblahblahblahblah.com', title: 'Bad Feed')
      expect{ bad_feed.save! }.to raise_error(ActiveRecord::RecordNotSaved)
    end
  end

end
