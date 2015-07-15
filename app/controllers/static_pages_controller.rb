#= Static pages

class StaticPagesController < ApplicationController

  def static
    begin
      if params[:path] =~ /\A[a-z0-9\-_\.]*\z/i
        render params[:path]
      end
    rescue ActionView::MissingTemplate
      render_404
    end
  end

end
