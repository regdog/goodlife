# encoding: UTF-8
class SearchController < ApplicationController

  # feats quick checkin
  def live_search
    @feats = Feat.where("name like ?", "%#{params[:q]}%").order(:name) if params[:q].length > 0
    render :layout => false
  end

  # search feats, challenges, rewards
  def all_search
    @results ||= []
    feat_keyword ||= {:name_contains => params[:q]}
    reward_keyword ||= {:partner_business_name_contains => params[:q]}

    Feat.search(feat_keyword).all.each do |r|
      @results << r
    end if !Feat.search(feat_keyword).all.nil? && feat_keyword.length > 0

    Reward.search(reward_keyword).all.each do |r|
      @results << r
    end if !Reward.search(reward_keyword).all.nil? && reward_keyword.length > 0
  end

  def index
    @feat_search ||= {:title_or_description_contains => params[:search]}
    @user_search ||= {:name_contains => params[:search]}
    @reward_search = {:name_or_description_contains => params[:search]}
    
    @result ||= []

    get_result(Feat, @feat_search, @result)
    get_result(User, @user_search, @result)
    get_result(Reward, @reward_search, @result)
  end
  
  private
  
  def get_result(mod, search_hash, result)
    unless mod.search(search_hash).all.blank?
      mod.search(search_hash).all.each {|m| result << m}
    end
  end
end
