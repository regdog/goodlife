# encoding: UTF-8
class RewardsController < ApplicationController
  def index
    @page_title = "奖励自己和大家"
  end

  def local
    @page_title = "奖励自己和大家"
    parameters = {:partner_tag_name_starts_with => 'Local'}
    if params[:address] && params[:address] != ''
      parameters[:city_or_street_or_zipcode_contains] = params[:address]
    #else
    #  parameters[:partner_city_or_partner_street_or_partner_zip_code_contains] = 'chengdu'
    end
    if params[:keyword]
      parameters[:partner_business_name_contains] = params[:keyword]
    end
    if params[:type] && params[:type]!= 'all'
      parameters[:tags_name_equals] = params[:type]
    end
    @view_by = params[:type]
    @rewards = Reward.search(parameters).page(params[:page]).per(20)
  end

  def premium
    @rewards = Reward.premium
    @page_title = "奖励自己和大家"
  end

  def wishlist
    @rewards = current_user.wishes
    @page_title = "你的愿望清单"
  end

  def show
    @reward = Reward.find_by_permalink(params[:id])
    #render :layout => 'corp'
  end

  def want
    @reward = Reward.find_by_permalink(params[:id])
    current_user.add_wish(@reward)

    respond_to do |format|
      format.js
    end
  end

  def unwant
    @reward = Reward.find_by_permalink(params[:id])
    current_user.remove_wish(@reward)

    respond_to do |format|
      format.js
    end
  end

  def print
    @reward = Reward.find_by_permalink(params[:id])
    render :layout => 'print'
  end
end
