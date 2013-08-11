class FeedsController < ApplicationController
  prepend_before_filter :get_auth_token
  before_filter :authenticate_user!

  def index
    @feeds = Feed.find(:all, :order => "updated ASC")
    render json: @feeds
  end


  def show
    @feed = Feed.find(params[:id])
    render json: @feed, :include => { :entries => { :include => :links}, :links => {}}
  end

  private
  def get_auth_token
    puts "Getting Auth Token!"
    if auth_token = params[:auth_token].blank? && request.headers["X-AUTH-TOKEN"]
      params[:auth_token] = auth_token
      puts "Auth Token #{auth_token}"
    end
  end


end
