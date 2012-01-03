# encoding: UTF-8
class CheckinsController < ApplicationController
  respond_to :html, :js
  def index
    @checkins = Checkin.latest
    @page_title = "鼓励人们的事迹"
    @view_by = "Latest"
  end

  def epic
    @checkins = Checkin.epic
    @page_title = "很棒的事迹"
    @view_by = "Epic"
    render :index
  end

  def create
    @checkin = Checkin.new(params[:checkin])
    @checkin.user = current_user
    #@checkin.location = request.location
    #if @checkin.save
    #  redirect_to feats_path
    #end

    if @checkin.save
      respond_with @checkin, :layout => !request.xhr?
    end
  end

  def comment
    @checkin = Checkin.find(params[:id])
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    @checkin.comments << @comment

    respond_to do |format|
      format.js
    end
  end

  def comments
    @checkin = Checkin.find(params[:id])
    @comments = @checkin.comments

    respond_to do |format|
      format.js
    end
  end
end
