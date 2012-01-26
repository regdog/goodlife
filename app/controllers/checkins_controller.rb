# encoding: UTF-8
class CheckinsController < ApplicationController
  respond_to :html, :js
  def index
    @checkins = Checkin.everyone.latest.page(params[:page])
    @num_pages =  Checkin.latest.page(params[:page]).num_pages
    @page_title = "鼓励人们的事迹"
    @view_by = "Latest"
    if request.xhr?
      sleep(2)
      render :partial => @checkins
    end
  end

  def epic
    @checkins = Checkin.everyone.epic
    @page_title = "很棒的事迹"
    @view_by = "Epic"
    render :index
  end

  def create
    @checkin = Checkin.new(params[:checkin])
    @checkin.user = current_user
    #@checkin.location = "#{t(request.location.city.downcase, :scope => :cities)}, #{t(request.location.state.downcase, :scope => :states)}"
    #@checkin.location = "#{t('sichuan', :scope => :states)}, #{t('chengdu', :scope => :cities)}"

    #if @checkin.save
    #  redirect_to feats_path
    #end

    if @checkin.save
      #Notifier.checkin_notification(@checkin).deliver
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
