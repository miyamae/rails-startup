#= Custom for Devise::RegistrationsController

class Users::RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    if current_user.encrypted_password.present?
      resource.update_with_password(params)
    else
      # Password not required when no password
      resource.update_without_current_password(
        params.permit(:password, :password_confirmation, :email))
    end
  end

  def after_sign_up_path_for(resource)
    new_session_path(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    users_sign_up_confirm_path
  end

  def sign_up_confirm
    add_breadcrumb t('views.devise.registrations.new.title'), new_user_registration_path(resource)
    @title = t('views.devise.registrations.sign_up_confirm.title')
    flash.notice = nil
  end

  def after_update_path_for(resource)
    edit_registration_path(resource)
  end

  def destroy
    if ! params[:confirmed]
      flash[:alert] = t('crud.destroy.required_confirm')
    elsif ! (current_user && current_user.valid_password?(params[:password]))
      flash[:alert] = t('crud.destroy.invalid_password')
    end
    if flash[:alert]
      redirect_to edit_registration_path(resource_name)
    else
      super
    end
  end

end
