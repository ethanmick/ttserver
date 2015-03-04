class Users::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, :only => [:create ]


 def create
   self.resource = warden.authenticate!(auth_options)
   sign_in(resource_name, resource)
   self.resource.reset_authentication_token!
   render :json=> {:success=>true, :auth_token=>resource.authentication_token, :email=>resource.email}
 end


  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    if signed_out then render status: :ok else render status: :unauthorized end
  end

end


