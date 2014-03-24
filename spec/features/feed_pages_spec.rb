require 'spec_helper'

describe 'Feed Pages' do
  subject { page }

  describe 'Header' do
    before { visit feeds_path }

    it { should have_link 'Add New Feed', href: new_feed_path }
    it { should have_link 'Feeds', href: root_path }
    it { should have_link 'Save Order' }
  end

  describe '#index' do
    context 'Invalid feed path' do
      let!(:non_feed_path) { FactoryGirl.create(:feed, title: 'Google', url: 'http://www.google.com') }
      before { visit feeds_path }

      it { should have_link 'Remove?', href: feed_path(non_feed_path.id) }

      describe 'Remove' do
        it 'Drops the count by 1' do
          expect { click_link 'Remove?' }.to change(Feed, :count).by(-1)
        end
      end
    end
  end

  describe '#new' do
    before { visit new_feed_path }

    it { should have_title 'Add New Feed' }
  end

  describe '#edit' do
    let(:feed) { FactoryGirl.create(:feed) }
    before { visit edit_feed_path(feed) }

    it { should have_title 'Edit Feed' }

    it 'updates the feed with a valid url' do
      fill_in 'Title', with: 'Amazin Avenue'
      fill_in 'Url', with: 'http://www.amazinavenue.com/rss/current'
      click_button 'Save'
      expect(page).to_not have_css '#error_explanation'
      expect(page).to_not have_title 'Edit Feed'
    end

    it "doesn't update the feed with an invalid url" do
      fill_in 'Url', with: 'http://www.blahblahinvalidurlblah.com'
      click_button 'Save'
      expect(page).to have_css '#error_explanation'
    end
  end
end
