#= Base for REST API Controller

class Api::BaseController <  ActionController::Base
  include Garage::ControllerHelper

  respond_to :json

  before_filter :set_request

  rescue_from WeakParameters::ValidationError do
    head 400
  end

  rescue_from CanCan::AccessDenied, with: :render_403
  rescue_from ActionView::MissingTemplate, with: :render_404
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404(exception=nil)
    if exception
      logger.error "Rendering 404 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
    end
    render status: 404, json: { error: { message: 'Not Found'} }
  end

  def render_403(exception=nil)
    if exception
      logger.error "Rendering 403 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
    end
    render status: 403, json: { error: { message: 'Forbidden'} }
  end

  def current_resource_owner
    @current_resource_owner ||= User.find(resource_owner_id) if resource_owner_id
  end

  def set_request
     Thread.current[:request] = request
     Thread.current[:current_user] = current_user
  end

end
