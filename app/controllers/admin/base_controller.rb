#= 管理システムトップページ

class Admin::BaseController < ApplicationController

  layout 'admin'

  add_breadcrumb I18n.t('views.admin.title'), :admin_root_path

  before_filter :authenticate_user!
  before_filter :authorize_role_admin!

  def authorize_role_admin!
     authorize! :manage, :all
  end

  def index
    @title = Const::PRODUCT + ' ' + I18n.t('views.admin.title')
  end

end
