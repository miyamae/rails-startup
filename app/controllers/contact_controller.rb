#= 問い合わせフォーム

class ContactController < ApplicationController

  add_breadcrumb 'お問い合わせ', :contact_index_path

  def index
    @title ||= breadcrumbs.last.name
    @contact ||= Contact.new
    render :index
  end

  def create
    @contact = Contact.new(params[:contact])
    if @contact.valid?
      @title = 'お問い合わせを受け付けました'
      @contact.sendmail
    else
      index
    end
  end

end
