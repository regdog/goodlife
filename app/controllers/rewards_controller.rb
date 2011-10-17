class RewardsController < ApplicationController
  def index
    redirect_to local_rewards_path
  end

  def local
    if params[:type]
      @category = Tag.of_kind("Reward").find_by_name(params[:type]) if params[:type]
      if @category
        @rewards = @category.rewards
      end
    else
      @rewards = Reward.all
    end
    render :index
  end

  def premium
    render :index
  end

  def wishlist
    render :index
  end

  def show
    @reward = Reward.find(params[:id])
    render :layout => 'corp'
  end

end
