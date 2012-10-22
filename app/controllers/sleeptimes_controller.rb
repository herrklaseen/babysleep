class SleeptimesController < ApplicationController

  def index 
    @sleeptimes = Sleeptime.find_all_by_baby_id(params[:baby_id])
    @baby = Baby.find_by_id(params[:baby_id])

    respond_to do |format|
      format.html
      format.json { render json: @sleeptimes }
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



end
