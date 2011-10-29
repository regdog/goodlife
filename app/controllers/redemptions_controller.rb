class RedemptionsController < ApplicationController
  def new
    @redemption = Redemption.new
    @reward = Reward.find(params[:reward_id])
  end

  def create
    @redemption = Redemption.new(params[:redemption])
    if @redemption.save
      redirect_to :action => :print
    end
  end

  def print

  end
end
