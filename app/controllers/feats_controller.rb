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
  end

  def plans
    case params[:type]
      when 'Daily'
        @feats = current_user.daily_feats
      when 'Weekly'
        @feats = current_user.weekly_feats
      when 'Weekend'
        @feats = current_user.weekend_feats
      else
        @feats = current_user.planned_feats
    end
    @view_by = params[:type]
  end

  def challenges
    case params[:type]
      when 'By Date'
        @challenges = Challenge.all
      when 'By Popularity'
        @challenges = Challenge.sort_by_popularity
      when 'By Points'
        @challenges = Challenge.sort_by_points
      when 'My Challenges'
        @challenges = current_user.challenges
      else
       @challenges = Challenge.all
    end
    @view_by = params[:type]
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
