class CheckinsController < ApplicationController
  layout 'main'

  def index
    @checkins = Checkin.all
  end

  def show_my_team
    @checkins ||= []
    @my_team.each do |m|
      @checkins << m.checkins
    end
    @checkins.flatten!
    @checkins = @checkins.sort_by {|c| [c.created_at]}
    render :index, :collection =>  @checkins
  end

  def show_my_challenges
    render :action => 'index'
  end

  def all
    render :action => 'index.html.erb'
  end
end
