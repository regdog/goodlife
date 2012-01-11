# encoding: UTF-8
class MemberController < ApplicationController
  def show
    @member = User.find_by_permalink(params[:permalink])
    @page_title = "#{@member.name}"
  end
end
