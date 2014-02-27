class FeedsController < ApplicationController

  def index
    @all_feeds = Feed.order(feed_order: :asc)
    @feed = Feedzirra::Feed.fetch_and_parse(@all_feeds.map(&:url))

  end
  
  def update_feed_order
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

  end

  def edit

  end

  def destroy
    @feed = Feed.find(params[:id]).destroy
    redirect_to root_url

  end

  private
  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
