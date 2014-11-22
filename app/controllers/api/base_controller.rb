#= APIコントローラの基底

class Api::BaseController < ApplicationController

  include Garage::ControllerHelper

  def current_resource_owner
    @current_resource_owner ||= User.find(resource_owner_id) if user_signed_in?
  end

end
