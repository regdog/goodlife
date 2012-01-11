# encoding: UTF-8
class RedemptionsController < ApplicationController
  def new
    @redemption = Redemption.new
    @reward = Reward.find_by_permalink(params[:reward_id])
    @page_title = "兑换奖励"
  end

  def create
    @redemption = Redemption.new(params[:redemption])
    @redemption.user_id = current_user.id
    @redemption.reward_id = Reward.find_by_permalink(params[:reward_id]).id
    if @redemption.save
      @reward = Reward.find_by_permalink(params[:reward_id])
      redirect_to print_reward_path(@reward)
    end
  end
end
