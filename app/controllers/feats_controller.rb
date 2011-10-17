class FeatsController < ApplicationController
  def index
    redirect_to catalog_feats_path
  end

  def catalog
    if params[:type]
      @category = Tag.of_kind("Feat").find_by_name(params[:type])
      @feats = @category.feats if @category
      @view_by = params[:type]
    else
      @feats = Feat.all
    end
    render :index
  end

  def show
    @feat = Feat.find(params[:id])
    render :layout => 'corp'
  end

  def checkin
    feat = Feat.find(params[:id])
    if current_user
      current_user.checkin(feat)
    end
    redirect_to :back
  end
end
