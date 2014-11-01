#= CRUD機能の基底
#
# class UserController < ApplicationController
#   include CrudController
#   model User             # 対象のModel
#   permit :name, :email   # Strong Parameters
#   destroy :cautious      # 削除モード

module CrudController
  extend ActiveSupport::Concern

  module ClassMethods
    @@model = {}
    @@permit = {}
    @@destroy = {}

    def model(value=nil)
      @@model[self] ||= value
    end

    def permit(*values)
      @@permit[self] ||= values
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
    model.all
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
    @title = '追加' unless @title
    @record = new_model(record_params) unless @record
    @subtitle = model_name unless @subtitle
    add_breadcrumb model_name, action: :index
    add_breadcrumb @title
    form
  end

  def create
    if params[:cancel]
      flash[:alert] = "#{model_name}を追加しませんでした。"
      redirect_to action: :index
    else
      @record = new_model
      set_attributes(@record, record_params)
      if @record.errors.empty? && @record.save
        flash[:notice] = "#{model_name}「#{@record}」を追加しました。"
        redirect_to action: :show, id: @record
      else
        new
        render :new
      end
    end
  end

  def edit
    @record = model_find(params[:id]) unless @record
    @title = '変更' unless @title
    @subtitle = "#{model_name} / #{@record}"
    add_breadcrumb model_name, action: :index
    add_breadcrumb @record_title || @record, action: :show, id: @record
    form
  end

  def update
    @record = model_find(params[:id])
    @record_title = @record.to_s
    if params[:cancel]
      flash[:alert] = "#{model_name}「#{@record}」を変更しませんでした。"
      redirect_to action: :show, id: @record
    else
      set_attributes(@record, record_params)
      if @record.errors.empty? && @record.save
        flash[:notice] = "#{model_name}「#{@record}」を変更しました。"
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
        flash[:alert] = "削除に同意してください。"
      elsif ! (current_user && current_user.valid_password?(params[:password]))
        flash[:alert] = "パスワードが違います。"
      end
    end
    if flash[:alert]
      redirect_to action: :edit, id: @record
    else
      if @record.destroy
        flash[:notice] = "#{model_name}「#{title}」を削除しました。"
      else
        flash[:alert] = "#{model_name}「#{title}」を削除できませんでした。"
      end
      redirect_to action: :index
    end
  end

end
