#= Settings for me

class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def profile
    add_breadcrumb I18n.t('views.users.show.my_page'), user_path(current_user)
    @title = I18n.t('views.settings.profile.title')
    @user ||= current_user
    render :profile
  end

  def update_profile
    @user = current_user
    @user.attributes = params.require(:user).permit(:nick_name, :bio, :image)
    params[:remove_images].to_a.each { |img| @user.send("#{img}=", nil) }
    if @user.save
      flash[:notice] = I18n.t('views.settings.profile.updated')
      redirect_to settings_profile_path
    else
      profile
    end
  end

  def oauth
    add_breadcrumb I18n.t('views.users.show.my_page'), user_path(current_user)
    @title = I18n.t('views.settings.oauth.title')
  end

  def oauth_remove
    if current_user.email.present? && current_user.encrypted_password.present?
      if params[:provider] == 'facebook'
        current_user.update_attributes!(facebook_uid: nil)
        flash[:notice] = I18n.t('views.settings.oauth.disconnected', provider: 'Facebook')
      elsif params[:provider] == 'twitter'
        current_user.update_attributes!(twitter_uid: nil)
        flash[:notice] = I18n.t('views.settings.oauth.disconnected', provider: 'Twitter')
      elsif params[:provider] == 'google'
        current_user.update_attributes!(google_uid: nil)
        flash[:notice] = I18n.t('views.settings.oauth.disconnected', provider: 'Google')
      end
    else
      flash[:alert] = I18n.t('views.settings.oauth.required_email_password')
    end
    redirect_to settings_oauth_path
  end

end
