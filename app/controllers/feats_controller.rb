# encoding: UTF-8
class FeatsController < ApplicationController
  respond_to :json, :only => :feat_tokens

  def index
    redirect_to catalog_feats_path
  end

  def catalog
    @page_title = "今天你做了什么事儿？"
    if params[:type]
      @category = Tag.of_kind("Feat").find_by_name(params[:type])
      @feats = @category.feats.page(params[:page]).per(20) if @category
      @view_by = params[:type]
    else
      @feats = Feat.order(:name).page(params[:page]).per(20)
      @view_by = "all"
    end
    render :index
  end

  def show
    @feat = Feat.find(params[:id])
    @page_title = @feat.name
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
    @feat = Feat.find(params[:id])
  end

  def feat_tokens
    if !params[:q]
      @feats = Feat.all
    else
      @feats = Feat.where("name like ?", "%#{params[:q]}%").order(:name)
    end

    ActiveRecord::Base.include_root_in_json = false
    respond_with(@feats.to_json(:only=>[:id, :name]))
  end
end
