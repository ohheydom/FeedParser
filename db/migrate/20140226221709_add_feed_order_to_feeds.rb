class AddFeedOrderToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :feed_order, :integer
  end
end
