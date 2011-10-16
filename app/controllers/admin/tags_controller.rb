class Admin::TagsController < Admin::BaseController
  respond_to :json, :only => [:feat_tag_tokens, :reward_tag_tokens]

  def index
    @search = Tag.search(params[:search])
    if params[:type] && Tag::KINDS.include?(params[:type])
      @view_by = params[:type]
      @tags = Tag.find_all_by_kind(@view_by)
    else
      @view_by = "Feat"
      @tags = Tag.of_kind("Feat")
    end
  end

  def new
    @tag = Tag.new
    if params[:type] && Tag::KINDS.include?(params[:type])
      @tag.kind = params[:type]
    else
      redirect_to :action => "new"
    end
  end

  def create
    @tag = Tag.new(params[:tag])

    if @tag.save
      redirect_to :action => "index", :type => @tag.kind
    else
      redirect_to :action => "new"
    end
  end

  def edit
    #@tag = Tag.find(params[:id]).becomes(Tag)
    @tag = Tag.find(params[:id])
  end

  def update
    @tag = Tag.find(params[:id])

    if @tag.update_attributes(params[:tag])
       redirect_to :action => "index", :type => @tag.kind
    else
       redirect_to :action => "edit"
    end
  end

  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy
    flash[:notice] = "Tag deleted!"
    redirect_to :action => "index", :type => @tag.kind
  end

  def feat_tag_tokens
    if !params[:q]
      @tags = Tag.of_kind("Feat")
    else
      @tags = Tag.with_name_like_and_kind(params[:q], "Feat")
    end

    ActiveRecord::Base.include_root_in_json = false
    respond_with(@tags.to_json(:only=>[:id, :name]))
  end

  def reward_tag_tokens
    if !params[:q]
      @tags = Tag.of_kind("Reward")
    else
      @tags = Tag.with_name_like_and_kind(params[:q], "Reward")
    end

    ActiveRecord::Base.include_root_in_json = false
    respond_with(@tags.to_json(:only=>[:id, :name]))
  end
end

