Garage.configure {}

Garage::TokenScope.configure do
  register :public, desc: 'acessing publicly available data' do
    access :read, User
    access :write, User
  end
end

Doorkeeper.configure do
  orm :active_record
  default_scopes :public
  optional_scopes(*Garage::TokenScope.optional_scopes)

  resource_owner_from_credentials do |routes|
    request.params[:user] = {email: request.params[:username], password: request.params[:password]}
    request.env["devise.allow_params_authentication"] = true
    request.env["warden"].authenticate(scope: :user)
  end

  resource_owner_authenticator do |routes|
    current_user || warden.authenticate(scope: :user)
  end

  admin_authenticator do |routes|
    if signed_in?
      unless current_user.has_role?(:admin)
        flash[:alert] = "You don't have access to that application."
        redirect_to routes.root_path
      end
    else
      flash[:alert] = "You must be logged in to access to that application."
      redirect_to routes.new_user_session_path
    end
  end

end
