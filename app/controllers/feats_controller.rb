class FeatsController < ApplicationController
  def index
    if params[:type]
      @category = Category.feat_category.find_by_name(params[:type]) if params[:type]
      if @category
        @feats = @category.feats
      end
    else
      redirect_to all_feats_path
    end
  end

  def all
    @feats = Feat.all
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
