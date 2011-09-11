class Admin::FeatsController < Admin::BaseController
  def index
    list
    render :action => 'list'
  end

  def list
    @search = Feat.search(params[:search])
    @feats = @search.all
  end

  def new
    @feat = Feat.new
    @feat.build_image
  end

  def create
    @feat = Feat.new(params[:feat])

    respond_to do |format|
      if @feat.save
        format.html { redirect_to(@feat, :notice => 'Feat was successfully created.') }
        format.xml { render :xml => @feat, :status => :created, :location => @feat }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @feat.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @feat = Feat.find(params[:id])
    @search = Feat.search(params[:search])
  end

  def update
    @feat = Feat.find(params[:id])

    respond_to do |format|
      if @feat.update_attributes(params[:feat])
        format.html { redirect_to(@feat,:notice => 'Feat was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @feat.errors,:status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @feat = Feat.find(params[:id])
    @feat.destroy
    redirect_to admin_feats_path
  end

  def list_by_category
    list

    if params[:key]
      @category_search = FeatCategory.search(:name_equals=>params[:key])
      @category = @category_search.all
      if @category.empty?
        redirect_to :action => "index"
        return
      else
        @feats = @category[0].feats
        render :action => "list"
      end
    end
  end
end
