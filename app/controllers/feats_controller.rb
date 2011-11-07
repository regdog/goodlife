class FeatsController < ApplicationController
  def index
    redirect_to catalog_feats_path
  end

  def catalog
    if params[:type]
      @category = Tag.of_kind("Feat").find_by_name(params[:type])
      @feats = @category.feats.page(params[:page]).per(20) if @category
      @view_by = params[:type]
    else
      @feats = Feat.order(:name).page(params[:page]).per(20)
    end
    render :index
  end

  def show
    @feat = Feat.find(params[:id])
    #render :layout => 'corp'
  end

  def plan
    @feat = Feat.find(params[:id])
    @plan_type = params[:type]
    if @plan_type == 'unplan'
      PlannedTodo.find_by_user_id_and_feat_id(current_user.id, @feat.id).destroy
    else
      current_user.plan(@feat, @plan_type)
    end
    respond_to do |format|
      format.js
    end
  end

  def checkin
    feat = Feat.find(params[:id])
    if current_user
      current_user.checkin(feat)
    end
    redirect_to :back
  end
end
