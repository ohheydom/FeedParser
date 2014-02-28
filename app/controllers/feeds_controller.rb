class FeedsController < ApplicationController

  def index
    @all_feeds = Feed.all.order(:feed_order)
    @feed = Feedzirra::Feed.fetch_and_parse(@all_feeds.map(&:url))
  end
  
  def update_feed_order
    new_sort_order = params[:sort_order].map! {|num| num[/\d+-\d+/].split("-").map(&:to_i) }

    new_sort_order.each_with_index do |arr,ind|      
      Feed.find(arr[0]).update_column(:feed_order, ind+1)
    end
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
