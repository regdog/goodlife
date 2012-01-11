class ContentsController < ApplicationController
  layout 'corp'

  def show
    @page = Content.find_by_permalink(params[:permalink])
  end
end
