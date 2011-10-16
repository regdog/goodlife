class Admin::ContentsController < Admin::BaseController
  def index
    if params[:type] && Tag.of_kind("Content").include?(params[:type])
      @view_by = params[:type]
      @category = Tag.of_kind("Content").find_by_name(params[:type])
    else
      @contents = Content.all
    end
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(params[:content])

    if @content.save
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @content = Content.find_by_permalink!(params[:id]).becomes(Content)
  end

  def update
    @content = Content.find_by_permalink!(params[:id])

    if @content.update_attributes(params[:content])
       redirect_to :action => "index"
    else
       redirect_to :action => "edit"
    end
  end

  def destroy
    @content = Content.find(params[:id])
    @content.destroy
    flash[:notice] = "Content deleted!"
    redirect_to :action => "index"
  end
end
