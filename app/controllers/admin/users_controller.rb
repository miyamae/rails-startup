#= (Admin) Users

class Admin::UsersController < Admin::BaseController
  include CrudController

  model User
  destroy :cautious
  permit :key, :name, :nick_name, :email, :image,
    :password, :password_confirmation, role_ids: []

  def record_params
    params = super
    if action_name == 'update' && params[:password] == ''
      return params.delete_if {|k, v|
        ['password', 'password_confirmation'].include?(k)}
    else
      return params
    end
  end

  def set_attributes(record, attrs)
    super
    record.skip_confirmation!
    record.skip_reconfirmation!
  end

  def login
    if current_user.valid_password?(params[:password])
      user = User.friendly.find(params[:id])
      sign_in user
      flash[:notice] = t('views.admin.users.signed_in', user: user)
      redirect_to root_path
    else
      flash[:alert] = t('views.admin.users.invalid_password')
      redirect_to admin_user_path
    end
  end

end
