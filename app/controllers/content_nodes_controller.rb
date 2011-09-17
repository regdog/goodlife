class  ContentNodesController < ApplicationController
  layout 'corp'

  def show
    @page = ContentNode.find_by_permalink(params[:permalink])
  end
end
