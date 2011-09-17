class CorpController < ApplicationController
  layout 'application'

  def show
    @page = ContentNode.find_by_permalink(params[:permalink])
  end
end
