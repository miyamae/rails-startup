#= 管理システムトップページ

class Admin::BaseController < ApplicationController

  layout 'admin'

  add_breadcrumb '管理システム', :admin_root_path

  before_filter :authenticate_user!
  before_filter :authorize_role_admin!

  def authorize_role_admin!
     authorize! :manage, :all
  end

  def index
    @title = Const::PRODUCT + ' 管理システム'
  end

end
