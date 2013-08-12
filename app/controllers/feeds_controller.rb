class FeedsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @feeds = current_user.feeds(:order => "updated ASC")
    render json: @feeds
  end


  def show

    begin
      @feed = current_user.feeds.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { :errors => "That feed was not found" } and return
    end

    render json: @feed, :include => { :entries => { :include => :links}, :links => {}}
  end

end
