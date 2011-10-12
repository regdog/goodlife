class RewardsController < ApplicationController

  def index
    if params[:type]
      @category = Category.reward_category.find_by_name(params[:type]) if params[:type]
      if @category
        @rewards = @category.rewards
      end
    else
      redirect_to all_rewards_path
    end
  end

  def all
    @rewards = Reward.all
    render :index
  end

  def show
    @reward = Reward.find(params[:id])
    render :layout => 'corp'
  end

end
