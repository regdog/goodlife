class CheckinsController < ApplicationController
  def index
    @checkins = Checkin.latest
  end

  def epic
    @checkins = Checkin.epic
    render :index
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
