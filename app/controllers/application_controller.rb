#= Base for all controllers

class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :params_toutf8, :params_strip, :default_header,
    :set_session_uuid, :set_request, :set_root_breadcrumb, :set_locale
  after_action :store_location

  if Rails.env.production?
    rescue_from Exception, with: :render_500
    rescue_from CanCan::AccessDenied, with: :render_403
    rescue_from ActionView::MissingTemplate, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  # Called when RoutingError
  def raise_not_found!
    raise ActionController::RoutingError.new(
      "No route matches #{params[:unmatched_route]}")
  end

  # Catched Exception, response 404
  def render_404(exception=nil)
    if exception
      logger.error "Rendering 404 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
    end
    breadcrumbs.clear
    @error = [404, 'Not Found']
    render status: 404, template: 'errors/default.html'
  end

  # Catched Exception, response 403
  def render_403(exception=nil)
    if exception
      logger.error "Rendering 403 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
    end
    breadcrumbs.clear
    @error = [403, 'Forbidden']
    render status: 403, template: 'errors/default.html'
  end

  # Catched Exception, response 500
  def render_500(exception=nil)
    if exception
      logger.error "Rendering 500 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
      ExceptionNotifier.notify_exception(exception, env: request.env)
    end
    breadcrumbs.clear
    @error = [500, 'Internal Server Error']
    render status: 500, template: 'errors/default.html'
  end

  # Strip white spaces in request parameters
  def params_strip
    all_strip!(params)
  end

  # Convert to UTF-8 in request parameters
  def params_toutf8
    all_toutf8!(params)
  end

  # Default HTTP response header
  def default_header
    headers['Cache-Control'] = 'no-cache'
    headers['P3P'] = "CP='UNI CUR OUR'"
  end

  # Set user identification to session
  def set_session_uuid
    if session[:session_uuid].blank?
      session[:session_uuid] = SecureRandom.uuid
    end
  end

  # Store current URL
  def store_location
    if !request.xhr? && request.fullpath !~
        %r{^/(users$|users/(sign_|password|confirmation|auth|redirect_oauth))}
      session[:previous_url] = request.fullpath
    else
      session[:previous_url] ||= root_path
    end
  end

  # Path for after sign in
  # def after_sign_in_path_for(resource)
  #   path = stored_location_for(resource) || session[:previous_url] || root_path
  #   logger.info "after_sign_in_path: #{path}"
  #   path
  # end

  # Path for after sign out
  # def after_sign_out_path_for(resource)
  # end

  # Store request for referernce in model
  def set_request
     Thread.current[:request] = request
     Thread.current[:current_user] = current_user
  end

  # Set I18n.locale
  def set_locale
    I18n.locale = I18n.default_locale
  end

  # Strip white spaces in array
  def all_strip!(var)
    if var.is_a?(Array)
      var.each { |v| all_strip!(v) }
    elsif var.is_a?(Hash)
      var.each { |k, v| all_strip!(v) }
    elsif var.is_a?(String)
      var.strip!
    end
  end

  # Convert to UTF-8 in array
  def all_toutf8!(var)
    if var.is_a?(Array)
      var.each { |v| all_toutf8!(v) }
    elsif var.is_a?(Hash)
      var.each { |k, v| all_toutf8!(v) }
    elsif var.is_a?(String)
      var.replace(var.encode('UTF-8', invalid: :replace, undef: :replace))
    end
  end

  # Set top page to breadcrumbs
  def set_root_breadcrumb
    add_breadcrumb '<span class="fa fa-lg">&#xf015</span><span class="sr-only">Top</span>'.html_safe, root_path
  end

end
