#= トップページ

class BaseController < ApplicationController

  def index
    @title = Const::PRODUCT
  end

end
