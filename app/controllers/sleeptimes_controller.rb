class SleeptimesController < ApplicationController

  def index 
    @sleeptimes = Sleeptime.find_all_by_baby_id(params[:baby_id])
    @baby = Baby.find_by_id(params[:baby_id])

    respond_to do |format|
      format.html
      format.json { render json: @sleeptimes }
    end    
  end

  def new
    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.new(:baby => @baby)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end


  def create
    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.make_instance(params[:start], params[:end], @baby)
    @sleeptime.save
    respond_to do |format|
      format.html { redirect_to "/babies/#{@baby.id}/last_24h_sleeptime"}
      format.json { render json: @sleeptimes }
    end
  end  

  def edit
    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @sleeptime }
    end
  end

  def update
    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.find_by_id(params[:id])
    @sleeptime.starttime = params[:start]
    @sleeptime.endtime = params[:end]
    respond_to do |format|
      format.html { redirect_to baby_sleeptimes_path }
      format.json { render json: @sleeptime }
    end
  end

  def destroy
    @sleeptime = Sleeptime.find_by_id(params[:id])
    @sleeptime.destroy
    respond_to do |format|
      format.html { redirect_to baby_sleeptimes_path }
      format.json { render json: @sleeptime }
    end
  end



end
