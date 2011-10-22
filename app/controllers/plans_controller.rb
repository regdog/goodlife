class PlansController < ApplicationController
  def index
    @feats = current_user.planned_feats
    @view_by = "index"
  end

  def daily
    @feats = current_user.daily_feats
    @view_by = "daily"
    render :index
  end

  def weekly
    @feats = current_user.weekly_feats
    @view_by = "weekly"
    render :index
  end

  def weekend
    @feats = current_user.weekend_feats
    @view_by = "weekend"
    render :index
  end
end
