class Admin::FeatsController < Admin::BaseController
  respond_to :json, :only => :feat_tokens
  skip_before_filter :authenticate_admin_user!, :only => [:feats_token]

  def index
    @search = Feat.search(params[:search])
    if params[:type]
      @view_by = params[:type]
      @category = Tag.of_kind("Feat").find_by_name(params[:type])
      if @category
        @feats = @category.feats.page(params[:page]).per(8)
      end
    else
      @feats = Feat.order(:name).page(params[:page]).per(8)
    end
  end

  def new
    @feat = Feat.new
    @feat.build_image
  end

  def create
    @feat = Feat.new(params[:feat])
    @feat.creator = current_admin_user.partner if current_admin_user.partner

    if @feat.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @feat = Feat.find_by_permalink(params[:id])
    @search = Feat.search(params[:search])
  end

  def update
    @feat = Feat.find_by_permalink(params[:id])

    if @feat.update_attributes(params[:feat])
      redirect_to :action => "index"
    else
      redirect_to :action => "edit"
    end
  end

  def destroy
    @feat = Feat.find_by_permalink(params[:id])
    @feat.destroy
    redirect_to admin_feats_path
  end

  def feat_tokens
    if !params[:q]
      @feats = Feat.all
    else
      @feats = Feat.where("name like ?", "%#{params[:q]}%").order(:name)
    end

    ActiveRecord::Base.include_root_in_json = false
    respond_with(@feats.to_json(:only=>[:id, :name]))
  end
end
