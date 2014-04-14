class FeedsController < ApplicationController
  include FeedsHelper

  before_action :set_feed, only: [:edit, :update, :destroy]
  before_action :set_feed_array, only: [:index]
  after_action :set_time_cookie, only: [:index]

  FeedMap = Struct.new(:feed_order, :url, :id, :title)

  def index
    @feed = Feedzirra::Feed.fetch_and_parse(@all_feeds.map(&:url))
  end

  def show
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    respond_to do |format|
      if @feed.save
        format.html { redirect_to root_url }
      else
        format.html { render 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to root_url }
      else
        format.html { render 'edit' }
      end
    end
  end

  def edit
  end

  def destroy
    @feed.destroy
    redirect_to root_url
  end

  def set_feed_array
    @all_feeds = Feed.all.order(:feed_order)
    feed_array = @all_feeds.map { |feed| [feed[:feed_order], feed[:url], feed[:id], feed[:title]] }
                .sort_by { |x| x[0] }

    @feed_arr = feed_array.map { |feed| FeedMap.new(feed[0], feed[1], feed[2], feed[3]) }
  end

  def update_feed_order
    whenstring = 'feed_order = CASE id'
    new_sort_order = remove_non_digits(params[:sort_order]).each_with_index { |arr, ind| whenstring << " WHEN #{arr[0]} THEN #{ind + 1}" }
    whenstring << ' END'
    Feed.where(id: new_sort_order.map { |arr| arr[0] }).update_all(whenstring)
    redirect_to root_path
  end

  def set_feed
    @feed = Feed.find(params[:id])
  end

  private

  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
