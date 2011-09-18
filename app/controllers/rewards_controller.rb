class RewardsController < ApplicationController

  def index
    @tag = RewardCategory.find(params[:tag_id]) if params[:tag_id]
    if params[:search].blank?
      @rewards = @tag ? @tag.rewards : Reward.all
    else
    #  @episodes = Episode.search_published(params[:search], params[:tag_id])
    end
    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @reward = Reward.find(params[:id])
    render :layout => 'corp'
  end

end
