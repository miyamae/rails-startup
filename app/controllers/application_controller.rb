class ApplicationController < ActionController::Base
  include SslRequirement
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :params_toutf8, :params_strip, :default_header,
    :set_session_uuid, :set_request, :set_root_breadcrumb
  after_action :store_location

  if Rails.env.production?
    rescue_from Exception, with: :render_500
    rescue_from CanCan::AccessDenied, with: :render_403
    rescue_from ActionView::MissingTemplate, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
    rescue_from ActionController::RoutingError, with: :render_404
  end

  # RoutingError時に呼ばれる
  def raise_not_found!
    raise ActionController::RoutingError.new(
      "No route matches #{params[:unmatched_route]}")
  end

  # 例外発生時の404
  def render_404(exception=nil)
    if exception
      logger.error "Rendering 404 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
    end
    breadcrumbs.clear
    @error = [404, 'Not Found', '見つかりません。']
    render status: 404, template: 'errors/default.html'
  end

  # 例外発生時の403
  def render_403(exception=nil)
    if exception
      logger.error "Rendering 404 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
    end
    breadcrumbs.clear
    @error = [403, 'Forbidden', 'アクセスする権限がありません。']
    render status: 403, template: 'errors/default.html'
  end

  # 例外発生時の500
  def render_500(exception=nil)
    if exception
      logger.error "Rendering 500 with exception: #{exception.message}"
      logger.error exception.backtrace.join("\n")
      ExceptionNotifier.notify_exception(exception, env: request.env)
    end
    breadcrumbs.clear
    @error = [500, 'Internal Server Error', '内部的なエラーが発生しました。']
    render status: 500, template: 'errors/default.html'
  end

  # リクエストパラメータ値の前後の空白文字を取り除く
  def params_strip
    all_strip!(params)
  end

  # リクエストパラメータ値をUTF-8に変換
  def params_toutf8
    all_toutf8!(params)
  end

  # HTTPレスポンスヘッダ
  def default_header
    headers['Cache-Control'] = 'no-cache'
    headers['P3P'] = "CP='UNI CUR OUR'"
  end

  # セッションにユーザー識別IDをセット
  def set_session_uuid
    if session[:session_uuid].blank?
      session[:session_uuid] = UUIDTools::UUID.random_create.to_s
    end
  end

  # URLを記憶
  def store_location
    if !request.xhr? && request.fullpath !~
        %r{^/(users$|users/(sign_|password|confirmation|auth|redirect_oauth))}
      session[:previous_url] = request.fullpath
    else
      session[:previous_url] ||= root_path
    end
  end

  # ログイン直後の遷移
  # def after_sign_in_path_for(resource)
  #   path = stored_location_for(resource) || session[:previous_url] || root_path
  #   logger.info "after_sign_in_path: #{path}"
  #   path
  # end

  # ログアウト直後の遷移
  # def after_sign_out_path_for(resource)
  # end

  # Modelから参照できるようにrequestを保存
  def set_request
     Thread.current[:request] = request
     Thread.current[:current_user] = current_user
  end

  # 配列下のすべての文字列の前後空白を削除
  def all_strip!(var)
    if var.is_a?(Array)
      var.each { |v| all_strip!(v) }
    elsif var.is_a?(Hash)
      var.each { |k, v| all_strip!(v) }
    elsif var.is_a?(String)
      var.strip!
    end
  end

  # 配列下のすべての文字列をUTF-8に変換
  def all_toutf8!(var)
    if var.is_a?(Array)
      var.each { |v| all_toutf8!(v) }
    elsif is_a?(Hash)
      var.each { |k, v| all_toutf8!(v) }
    elsif var.is_a?(String)
      var.replace(var.encode('utf-8'))
    end
  end

  # パンくずにトップを設定
  def set_root_breadcrumb
    add_breadcrumb '<span class="fa fa-lg">&#xf015</span>' +
      '<span class="sr-only">Top</span>'.html_safe, root_path
  end

  # .ssl_requird :all
  # http://www.cocoalife.net/2009/08/post_843.html
  class << self
    def ssl_required_with_all(*actions)
      if actions.include?(:all)
        class_eval do
          def ssl_required?
            true
          end
        end
      else
        class_eval do
          ssl_required_without_all(*actions)
        end
      end
    end
    alias_method_chain(:ssl_required, :all)
  end

end
