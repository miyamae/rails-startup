#= ユーザー設定

class SettingsController < ApplicationController

  before_filter :authenticate_user!

  def profile
    add_breadcrumb 'マイページ', user_path(current_user)
    @title = 'プロフィール設定'
    @user ||= current_user
    render :profile
  end

  def update_profile
    @user = current_user
    @user.attributes = params.require(:user).permit(:nick_name, :bio, :image)
    params[:remove_images].to_a.each { |img| @user.send("#{img}=", nil) }
    if @user.save
      flash[:notice] = 'プロフィールを変更しました。'
      redirect_to settings_profile_path
    else
      profile
    end
  end

  def oauth
    add_breadcrumb 'マイページ', user_path(current_user)
    @title = '外部サイト連携'
  end

  def oauth_remove
    if current_user.email.present? && current_user.encrypted_password.present?
      if params[:provider] == 'facebook'
        current_user.update_attributes!(facebook_uid: nil)
        flash[:notice] = 'Facebookアカウントとの関連付けを解除しました。'
      elsif params[:provider] == 'twitter'
        current_user.update_attributes!(twitter_uid: nil)
        flash[:notice] = 'Twitterアカウントとの関連付けを解除しました。'
      elsif params[:provider] == 'google'
        current_user.update_attributes!(google_uid: nil)
        flash[:notice] = 'Googleアカウントとの関連付けを解除しました。'
      end
    else
      flash[:alert] = 'メールアドレスとパスワードが設定されていないため、外部サイト連携を解除できません。'
    end
    redirect_to settings_oauth_path
  end

end
