require 'spec_helper'

describe "Feed Pages" do
  subject { page }

  describe "Header" do
    before { visit feeds_path }
    it { should have_link 'Add New Feed', href: new_feed_path }
    it { should have_link 'Feeds', href: root_path }
  end

  describe "#index" do

    context "Invalid feed path" do
      let!(:non_feed_path) { FactoryGirl.create(:feed, title: 'Google', url: 'http://www.google.com') }
      before { visit feeds_path }
      it { should have_link 'Remove?', href: feed_path(non_feed_path.id) }

      describe "Remove" do
        it "Drops the count by 1" do
          expect { click_link 'Remove?'}.to change(Feed, :count).by(-1)
        end
      end
    end

    describe "Features" do
      before { visit feeds_path }
      it { should have_button 'Save Order' }
    end
  end

  describe "#new" do
    before { visit new_feed_path }
    it { should have_title 'Add New Feed' }

  end
end
