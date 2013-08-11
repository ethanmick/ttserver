class Users::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create ]
  respond_to :json
 
# def create
#   resource = User.find_for_database_authentication(:email => params[:user][:email])
#   return invalid_login_attempt unless resource
#
#   if resource.valid_password?(params[:user_login][:password])
#     sign_in(:user, resource)
#     resource.ensure_authentication_token!
#     render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
#     return
#   end
#   invalid_login_attempt
# end






 def create
   self.resource = warden.authenticate!(auth_options)
   sign_in(resource_name, resource)
   self.resource.reset_authentication_token!
   render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
 end


# def create
#   build_resource
#   resource = User.find_for_database_authentication(:login=>params[:user_login][:login])
#   if resource.nil?
#     render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
#   end
#
#   if resource.valid_password?(params[:user_login][:password])
#     sign_in("user", resource)
#     render :json=> {:success=>true, :auth_token=>resource.authentication_token, :login=>resource.login, :email=>resource.email}
#   else
#     render :json=> {:success=>false, :message=>"Error with your login or password"}, :status=>401
#   end
# end


# def create
#   respond_to do |format|
#     format.json {
#       warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
#       render :status => 200, :json => { :error => "Success" }
#     }
#   end
# end


  def destroy
    super
  end

end


