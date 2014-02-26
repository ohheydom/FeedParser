require 'spec_helper'

describe "Feed Pages" do
  subject { page }

  describe "Header" do
    before { visit feeds_path }
    it { should have_link 'Add New Feed', href: new_feed_path }
    it { should have_link 'Feeds', href: root_path }
  end

  describe "#index" do
  end

  describe "#new" do
    before { visit new_feed_path }
    it { should have_title 'Add New Feed' }

  end
end
