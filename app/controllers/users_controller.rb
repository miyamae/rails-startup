#= Users

class UsersController < ApplicationController

  def index
    @title = breadcrumbs.last.name
  end

  def show
    @user = User.friendly.find(params[:id])
    @title = @user
  end

end
