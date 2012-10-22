class BabiesController < ApplicationController
  def start
    respond_to do |format|
      format.html 
    end
  end


  # GET /babies
  # GET /babies.json
  def index
    @babies = Baby.find_all_by_parent_id(session[:parent_id])

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end

  def last_24h_sleeptime
    @baby = Baby.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @baby.last_24h_sleeptime }
    end
  end


end
