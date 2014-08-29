require 'rss'

class FeedsController < ApplicationController
  def new
    @feed = Feed.new
    @feeds = Feed.all.order("created_at DESC") || []
  end

  def index
    @feeds = Feed.all.order("created_at DESC")
  end

  def edit
    @feed = Feed.find(params[:id])
  end

  def show
   @feed = Feed.find(params[:id])
   @feed_url = @feed.feed_url

   @rss_feed = RSS::Parser.parse(@feed_url, false)

  end

  def create
    @feed = Feed.new(feed_params)
    if @feed.save
      flash[:success] = "Successfully created..."
      redirect_to new_feed_path
    else
      flash[:error] = "Please check the params"
      render 'new'
    end
  end

  def destroy
      @feed = Feed.find(params[:id])
      if @feed.destroy
        flash[:success] = "User deleted."
        #redirect_to feeds_url
        redirect_to new_feed_path
      else
        flash[:error] = "Problem in deleting feed.............."
      end
  end

  def update
      @feed = Feed.find(params[:id])
      if @feed.update_attributes(feed_params)
        flash[:success] = "Successfully updated the feed..."
        redirect_to feeds_url
      else
        flash[:error] = "Error in updating feed"
      end
  end

  private

      def feed_params
            params.require(:feed).permit(:feed_url)
      end
end
