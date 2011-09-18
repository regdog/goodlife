class Admin::TagsController < Admin::BaseController
  def index
    list
    render :action => 'list'
  end

  def list
    @search = Tag.search(params[:search])
    if params[:type] && Tag::TYPES.include?(params[:type])
      @view_by = params[:type]
      @tags = Tag.find_all_by_type(@view_by)
    else
      @tags = Tag.all
    end
  end

  def new
    @tag = Tag.new
    if params[:type] && Tag::TYPES.include?(params[:type])
      @tag.type = params[:type]
    else
      redirect_to :action => "new"
    end
  end

  def create
    @tag = Tag.new(params[:tag])
    @tag.type = params[:tag][:type]

    if @tag.save
      redirect_to :action => "index", :type => @tag.type
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @tag = Tag.find(params[:id]).becomes(Tag)
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(params[:tag])
       redirect_to :action => "index", :type => @tag.type
    else
       redirect_to :action => "edit"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "Tag deleted!"
    redirect_to :action => "index", :type => @tag.type
    #respond_to do |format|
    #  format.html { redirect_to :action => "index", :type => @tag.type }
    #  format.xml { head :ok }
    #end
  end
end
