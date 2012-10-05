class SleeptimesController < ApplicationController

  def index 
    @sleeptimes = Sleeptime.find_all_by_baby_id(params[:baby_id])

    respond_to do |format|
      format.json { render json: @sleeptimes }
    end    
  end

  def last_24h_sleeptime
    @sleeptimes = Sleeptime.find_all_by_baby_id(params[:baby_id])

    respond_to do |format|
      format.json { render json: @sleeptimes }
    end    
  end


end
