#= ユーザーAPI

class Api::UsersController < Api::BaseController
  include Garage::RestfulActions

  validates :index do
    integer :page, description: 'Parameter for pagination.'
    integer :per_page, description: 'Parameter for pagination.'
  end

  def require_resources
    @resources = User.all
  end

  def require_resource
    @resource = User.find(params[:id])
  end

  def update_resource
    @resource.update_attributes!(user_params)
  end

  def user_params
    params.permit(
      :name, :nick_name, :email, :password, :bio)
  end

  def respond_with_resources_options
    { paginate: true }
  end

end
