class Admin::ContentNodesController < Admin::BaseController
  def index
    list
    render :action => 'list'
  end

  def list
    if params[:type] && ContentNode::TYPES.include?(params[:type])
      @view_by = params[:type]
      @content_nodes = ContentNode.find_all_by_type(@view_by)
    else
      @content_nodes = ContentNode.all
    end
  end

  def new
    @content_node = ContentNode.new

    if params[:type] && ContentNode::TYPES.include?(params[:type])
      @content_node.type = params[:type]
    else
      @content_node.type = 'Page'
    end
  end

  def create
    @content_node = ContentNode.new(params[:content_node])
    @content_node.type = params[:content_node][:type]
#    @content_node.user = current_user

    if @content_node.save
      redirect_to :action => "index", :type => @content_node.type
    else
      redirect_to :action => "new"
    end
  end

  def edit
    @content_node = ContentNode.find_by_permalink!(params[:id]).becomes(ContentNode)
  end

  def update
    @content_node = ContentNode.find_by_permalink!(params[:id])

    if @content_node.update_attributes(params[:content_node])
       redirect_to :action => "index", :type => @content_node.type
    else
       redirect_to :action => "edit"
    end
  end
end
