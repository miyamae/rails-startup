#= Static pages

class StaticPagesController < ApplicationController

  def static
    begin
      render params[:path]
    rescue ActionView::MissingTemplate
      render_404
    end
  end

end
