class CheckinsController < ApplicationController
  respond_to :html, :json, :js

  def friends
    @checkins = Checkin.friends(current_user.friend_ids)

    render "index"
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @checkins }
    #end
  end

  def epics
    @checkins = Checkin.epics

    render "index"
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @checkins }
    #end
  end

  # GET /checkins
  # GET /checkins.json
  def index
    @checkins = Checkin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.json
  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkin }
    end
  end

  # GET /checkins/new
  # GET /checkins/new.json
  def new
    @checkin = Checkin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checkin }
    end
  end

  # GET /checkins/1/edit
  def edit
    @checkin = Checkin.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(params[:checkin])
    @checkin.user_id = 1

    respond_with @checkin, :layout => !request.xhr?

    #respond_to do |format|
    #  if @checkin.save
    #    format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
    #    format.json { render json: @checkin, status: :created, location: @checkin }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @checkin.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /checkins/1
  # PUT /checkins/1.json
  def update
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :ok }
    end
  end
end
