class RewardsController < ApplicationController

  def index
    if params[:type]
      @category = RewardCategory.find_by_name(params[:type]) if params[:type]
      if @category
        @rewards = @category.rewards
      end
    else
      @rewards = Reward.all
    end
  end

  def show
    @reward = Reward.find(params[:id])
    render :layout => 'corp'
  end

end
