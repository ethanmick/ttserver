class FeedsController < ApplicationController



  def index
    @feeds = Feed.find(:all, :order => "updated ASC")
    render json: @feeds
  end


  def show
    @feed = Feed.find(params[:id])
    render json: @feed, :include => { :entries => { :include => :links}, :links => {}}
  end


  def new

  end

  def created

  end

end
