class FeatsController < ApplicationController
  def index
    if params[:type]
      @category = Category.feats.find_by_name(params[:type]) if params[:type]
      if @category
        @feats = @category.feats
      end
    else
      redirect_to all_feats_path
    end
  end

  def all
    @feats = Feat.all
    render :index
  end

  def show
    @feat = Feat.find(params[:id])
    render :layout => 'corp'
  end

  def checkin
    user = current_user
    feat = Feat.find(:feat_id)
    if feat && user
      checkin = Checkin.new
      if user.challenge_feats.include?(feat)
        checkin.feat_id = params[:feat_id]
        checkin.user_id = user.id
        #checkin.challenge_id =
      else
        checkin.feat_id = params[:feat_id]
        checkin.user_id = user.id
      end

      if checkin.save
        feat.don_count = feat.don_count + 1
        feat.save
      end

    end
    redirect_to :back
  end
end
