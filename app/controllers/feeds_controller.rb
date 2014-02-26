class FeedsController < ApplicationController

  def index
    feeds = ['http://www.metsblog.com/feed', 'http://amazinavenue.com/rss/current']
    feeds << 'http://www.gsdfsdfsdffsdfsdoogle.com'
    @feed = Feedzirra::Feed.fetch_and_parse(feeds)
    @entries = @feed.entries

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

  end

  private
  def feed_params
    params.require(:feed).permit(:title, :url)
  end
end
