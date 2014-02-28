class FeedsController < ApplicationController
  after_action :set_time_cookie, only: [:index]

  def index
    @all_feeds = Feed.all.order(:feed_order)
    @feed_arr = @all_feeds.map{|feed| [feed[:feed_order], feed[:url], feed[:id], feed[:title]] }
                .sort_by {|x| x[0] }
    @feed = Feedzirra::Feed.fetch_and_parse(@all_feeds.map(&:url))
  end
  
  def update_feed_order
    new_sort_order = params[:sort_order].map! {|num| num[/\d+-\d+/].split("-").map(&:to_i) }
    whenstring = "feed_order = CASE id"
    new_sort_order.each_with_index { |arr, ind| whenstring << " WHEN #{arr[0]} THEN #{ind+1}" }
    whenstring << " END"

    Feed.where(id: new_sort_order.map { |arr| arr[0] }).update_all(whenstring)
  end

  def show

  end

  def new
    @feed = Feed.new
  end

  def set_time_cookie
    cookies.permanent[:last_viewed] = Time.now
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
