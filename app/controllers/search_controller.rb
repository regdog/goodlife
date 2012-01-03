# encoding: UTF-8
class SearchController < ApplicationController

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
