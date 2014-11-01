#= Deviseユーザー登録関連のカスタムController

class Users::RegistrationsController < Devise::RegistrationsController

  def update_resource(resource, params)
    if current_user.encrypted_password.present?
      resource.update_with_password(params)
    else
      # パスワード未設定の場合は現在のパスワード不要
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
    add_breadcrumb 'ユーザー登録', new_user_registration_path(resource)
    flash.notice = nil
    @title = '仮登録を行いました'
  end

  def after_update_path_for(resource)
    edit_registration_path(resource)
  end

  def destroy
    if ! params[:confirmed]
      flash[:alert] = "削除に同意してください。"
    elsif ! (current_user && current_user.valid_password?(params[:password]))
      flash[:alert] = "パスワードが違います。"
    end
    if flash[:alert]
      redirect_to edit_registration_path(resource_name)
    else
      super
    end
  end

end
