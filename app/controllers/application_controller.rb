class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActionController::RoutingError, :with => :error_render_method

  def error_render_method
    puts "HANDLING ERROR"
    render :json => {"error":"Method not found."}, :status => 404
    true
  end

end
