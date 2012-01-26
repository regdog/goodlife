# encoding: UTF-8
class PlansController < ApplicationController
  def index
    @feats = current_user.habits.page(params[:page]).per(20)
    @view_by = "index"
    @page_title = "我计划的事儿"
  end

  def daily
    @feats = Kaminari.paginate_array(current_user.daily_feats).page(params[:page]).per(20)
    @view_by = "daily"
    @page_title = "我计划的事儿"
    render :index
  end

  def weekly
    @feats = Kaminari.paginate_array(current_user.weekly_feats).page(params[:page]).per(20)
    @view_by = "weekly"
    @page_title = "我计划的事儿"
    render :index
  end

  def weekend
    @feats = Kaminari.paginate_array(current_user.weekend_feats).page(params[:page]).per(20)
    @view_by = "weekend"
    @page_title = "我计划的事儿"
    render :index
  end
end
