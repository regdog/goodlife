class FeatsController < ApplicationController

  def index
    @tag = FeatCategory.find(params[:tag_id]) if params[:tag_id]
    if params[:search].blank?
      @feats = @tag ? @tag.feats : Feat.all
    else
    #  @episodes = Episode.search_published(params[:search], params[:tag_id])
    end
    respond_to do |format|
      format.html
      format.rss
    end
  end

  def show
    @feat = Feat.find(params[:id])
    render :layout => 'corp'
  end

  def checkin
    unless params[:feat_id].blank?
      @checkin = Checkin.new
      @checkin.feat_id = params[:feat_id]
      @checkin.user_id = current_user.id
      if @checkin.save
        @feat = @checkin.feat
        @feat.done_count = @feat.done_count + 1
        @feat.save
      end
    end
    redirect_to :back
  end
end
