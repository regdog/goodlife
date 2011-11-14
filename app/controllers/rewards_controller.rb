class RewardsController < ApplicationController
  def index
  end

  def local
    parameters = {:partner_tag_name_starts_with => 'Local'}
    if params[:address] && params[:address] != ''
      parameters[:partner_city_or_partner_street_or_partner_zip_code_contains] = params[:address]
    #else
    #  parameters[:partner_city_or_partner_street_or_partner_zip_code_contains] = 'chengdu'
    end
    if params[:keyword]
      parameters[:name_contains] = params[:keyword]
    end
    if params[:type] && params[:type]!= 'all'
      parameters[:tags_name_equals] = params[:type]
    end

    @rewards = Reward.search(parameters).page(params[:page]).per(20)
  end

  def premium
    @rewards = Reward.premium
    @page_title
  end

  def wishlist
    @rewards = current_user.wishes
  end

  def show
    @reward = Reward.find(params[:id])
    render :layout => 'corp'
  end

  def add_wish
    @reward = Reward.find(params[:id])
    current_user.add_wish(@reward)

    respond_to do |format|
      format.js
    end
  end

  def remove_wish
    @reward = Reward.find(params[:id])
    current_user.remove_wish(@reward)

    respond_to do |format|
      format.js
    end
  end
end
