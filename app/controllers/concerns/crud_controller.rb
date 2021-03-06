#= Base for CRUD
#
# class UserController < ApplicationController
#   include CrudController
#   permit :name, :email   # Strong Parameters
#   destroy :cautious      # Destroy mode
#   search: :name, :bio    # Keyword search fields
#
#   # Target model
#   model User
#   # or filtered
#   source -> { User.enabled }
#   # or
#   def source
#     super -> { @site.users }
#   end

module CrudController
  extend ActiveSupport::Concern

  module ClassMethods
    @@model = {}
    @@source = {}
    @@permit = {}
    @@destroy = {}
    @@search = {}

    def source(value=nil)
      if value
        @@source[self] = value
        model(value.call.klass) unless model
      end
      return @@source[self]
    end

    def model(value=nil)
      if value
        @@model[self] = value
        source(-> { value.all }) unless source
      end
      return @@model[self]
    end

    def permit(*values)
      @@permit[self] ||= values
    end

    def search(*values)
      @@search[self] ||= values
    end

    def model_name
      model.model_name.human
    end

    # :normal / :cautious / :logical
    def destroy(mode=nil)
      @@destroy[self] ||= mode
    end
    def destroy_mode
      @@destroy[self]
    end
  end

  def source(value=nil)
    self.class.source(value).call
  end

  def model(value=nil)
    self.class.model(value)
  end

  def model_name
    self.class.model_name
  end

  def destroy_mode
    self.class.destroy_mode
  end

  def search
    def self.str_to_sbytes(str)
      str.to_s.tr('ａ-ｚＡ-Ｚ０-９　！”＃＄％＆（）＊＋，－．／：；＜＝＞？＠［￥］＾＿｀｛｜｝～',
        'a-zA-Z0-9 !"#$%&()*+,-./:;<=>?@[\]^_`{|}~')
    end
    if params[:q]
      fields = self.class.search
      query = fields.map {|f| "upper(#{f}) LIKE ?"}.join(' OR ')
      source.where(query + ' OR ' + query,
        *Array.new(fields.size, "%#{params[:q].upcase}%"),
        *Array.new(fields.size, "%#{str_to_sbytes(params[:q]).upcase}%"))
    else
      source
    end
  end

  def model_find(id)
    if model.respond_to?('friendly')
      search.friendly.find(id)
    else
      search.find(id)
    end
  end

  def index
    @title = model_name unless @title
    @records = search.page(params[:page]).per(15)
    add_breadcrumb @title
  end

  def show
    @record = model_find(params[:id])
    @title = @record.to_s unless @title
    @subtitle = model_name unless @subtitle
    add_breadcrumb model_name, action: :index
    add_breadcrumb @title
  end

  def record_params
    modelname = model.name.tableize.singularize
    return params[modelname] && params.require(modelname).permit(self.class.permit)
  end

  def set_attributes(record, attrs)
    record.attributes = attrs
    params[:remove_images].to_a.each { |img| record.send("#{img}=", nil) }
  end

  def form
  end

  def new_model(default_params=nil)
    model.new(default_params)
  end

  def new
    @title = t('crud.new.title') unless @title
    @record = new_model(record_params) unless @record
    @subtitle = model_name unless @subtitle
    add_breadcrumb model_name, action: :index
    add_breadcrumb @title
    form
  end

  def create
    if params[:cancel]
      flash[:alert] = t('crud.new.cancel', model: model_name)
      redirect_to action: :index
    else
      @record = new_model
      set_attributes(@record, record_params)
      if @record.errors.empty? && @record.save
        flash[:notice] = t('crud.new.done', model: model_name, name: @record)
        redirect_to action: :show, id: @record
      else
        new
        render :new
      end
    end
  end

  def edit
    @record = model_find(params[:id]) unless @record
    @title = t('crud.edit.title') unless @title
    @subtitle = "#{model_name} / #{@record}"
    add_breadcrumb model_name, action: :index
    add_breadcrumb @record_title || @record, action: :show, id: @record
    form
  end

  def update
    @record = model_find(params[:id])
    @record_title = @record.to_s
    if params[:cancel]
      flash[:alert] = t('crud.edit.cancel', model: model_name, name: @record)
      redirect_to action: :show, id: @record
    else
      set_attributes(@record, record_params)
      if @record.errors.empty? && @record.save
        flash[:notice] = t('crud.edit.done', model: model_name, name: @record)
        redirect_to action: :show, id: @record
      else
        edit
        render :edit
      end
    end
  end

  def destroy
    @record = model_find(params[:id])
    title = @record.to_s
    if destroy_mode == :cautious
      if ! params[:confirmed]
        flash[:alert] = t('crud.destroy.required_confirm')
      elsif ! (current_user && current_user.valid_password?(params[:password]))
        flash[:alert] = t('crud.destroy.invalid_password')
      end
    end
    if flash[:alert]
      redirect_to action: :edit, id: @record
    else
      if @record.destroy
        flash[:notice] = t('crud.destroy.done', model: model_name, name: title)
      else
        flash[:alert] = t('crud.destroy.error', model: model_name, name: title)
      end
      redirect_to action: :index
    end
  end

end
