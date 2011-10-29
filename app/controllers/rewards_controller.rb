class RewardsController < ApplicationController
  def index
  end

  def local
    @search = Reward.search(params[:search])
    @rewards = @search.all if params[:search]
  end

  def premium
    @rewards = Reward.premium
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
