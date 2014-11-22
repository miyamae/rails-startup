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
    @resources = User.find(params[:id])
  end

  def respond_with_resources_options
    { paginate: true }
  end

end
