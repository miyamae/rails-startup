#= 問い合わせフォーム

class ContactController < ApplicationController

  add_breadcrumb 'お問い合わせ', :contact_index_path

  def index
    @title = breadcrumbs.last.name
    @contact ||= Contact.new
  end

  def create
    @title = 'お問い合わせを受け付けました'
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      @contact.sendmail
    else
      render :index
    end
  end

end
