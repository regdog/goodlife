class ContentsController < ApplicationController
  layout 'application'

  def show
    @page = Content.find_by_permalink(params[:permalink])
  end
end
