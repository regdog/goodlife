class CommentsController < ApplicationController
  def index
    @checkin = Checkin.find(params[:checkin_id])
    @comments = @checkin.comments
    respond_to do |format|
      format.js
    end
  end

  def create
    @checkin = Checkin.find(params[:checkin_id])
    if params[:content]
      @comment = Comment.create
      @comment.content = params[:content]
    else
      @comment = Comment.new(params[:comment])
    end
    @comment.user_id = current_user.id
    @checkin.comments << @comment

    respond_to do |format|
      format.js
    end
  end
end
