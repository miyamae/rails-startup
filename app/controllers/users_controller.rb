#= ユーザー

class UsersController < ApplicationController

  # add_breadcrumb 'ユーザー', :users_path

  def index
    @title = breadcrumbs.last.name
  end

  def show
    @user = User.friendly.find(params[:id])
    @title = @user
  end

end
