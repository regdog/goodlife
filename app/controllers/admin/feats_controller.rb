class Admin::FeatsController < Admin::BaseController
  def index
    list
    render :action => 'list'
  end

  def list
    @search = Feat.search(params[:search])
    if params[:type]
      @category = FeatCategory.find(params[:type])
      if @category
        @feats = @category.feats
      end
    else
      @feats = Feat.all
    end
  end

  def new
    @feat = Feat.new
    @feat.build_image
  end

  def create
    @feat = Feat.new(params[:feat])

    if @feat.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @feat = Feat.find(params[:id])
    @search = Feat.search(params[:search])
  end

  def update
    @feat = Feat.find(params[:id])

    if @feat.update_attributes(params[:feat])
      redirect_to :action => "index"
    else
      redirect_to :action => "edit"
    end
  end

  def destroy
    @feat = Feat.find(params[:id])
    @feat.destroy
    redirect_to admin_feats_path
  end
end
