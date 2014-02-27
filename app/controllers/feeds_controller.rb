class FeedsController < ApplicationController

  def index
    @database_feeds = Hash[Feed.order(feed_order: :asc).pluck(:title, :url)]
    @feed = Feedzirra::Feed.fetch_and_parse(@database_feeds.values)

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
