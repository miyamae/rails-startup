#= OAuth Callbacks

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth(request.env['omniauth.auth'], current_user)
    if @user.errors.present?
      flash[:alert] = @user.errors.full_messages.join
      redirect_to session[:previous_url]
    elsif @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Facebook'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.find_for_twitter_oauth(request.env['omniauth.auth'], current_user)
    if @user.errors.present?
      flash[:alert] = @user.errors.full_messages.join
      redirect_to session[:previous_url]
    elsif @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Twitter'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.twitter_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    @user = User.find_for_google_oauth(request.env['omniauth.auth'], current_user)
    if @user.errors.present?
      flash[:alert] = @user.errors.full_messages.join
      redirect_to session[:previous_url]
    elsif @user.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_oauth2_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def redirect_oauth
    breadcrumbs.clear
  end

end
