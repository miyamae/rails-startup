#= 問い合わせフォーム

class ContactController < ApplicationController

  add_breadcrumb I18n.t('views.contact.title'), :contact_index_path

  def index
    @title ||= breadcrumbs.last.name
    @contact ||= Contact.new
    render :index
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      @title = I18n.t('views.contact.done_title')
      @contact.sendmail
    else
      index
    end
  end

end
