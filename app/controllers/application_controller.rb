class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

#  rescue_from ActionController::RoutingError, :with => :error_render_method
#  rescue_from NoMethodError, :with => :error_internal

  def error_render_method
    puts "HANDLING ERROR"
    render :json => { :errors => "Method not found." }, :status => :not_found
    true
  end

  def error_internal
    puts "Handling 500"
    render :json => { :errors => "Internal Server Error."}, :status => :internal_server_error
  end

end
