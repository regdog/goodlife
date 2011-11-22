class RedemptionsController < ApplicationController
  def new
    @redemption = Redemption.new
    @reward = Reward.find(params[:reward_id])
  end

  def create
    @redemption = Redemption.new(params[:redemption])
    @redemption.user_id = current_user.id
    @redemption.reward_id = params[:reward_id]
    if @redemption.save
      @reward = Reward.find(params[:reward_id])
      redirect_to print_reward_path(@reward)
    end
  end
end
