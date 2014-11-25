#= Base for REST API Controller

class Api::BaseController < ApplicationController

  include Garage::ControllerHelper

  respond_to :json

  rescue_from WeakParameters::ValidationError do
    head 400
  end

  def current_resource_owner
    @current_resource_owner ||= User.find(resource_owner_id) if resource_owner_id
  end

end
