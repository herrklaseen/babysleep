class BabiesController < ApplicationController
  def start
    respond_to do |format|
      format.html 
      format.mobile  
    end
  end


  # GET /babies
  # GET /babies.json
  def index
    @babies = Baby.find_all_by_parent_id(params[:parent_id])

    respond_to do |format|
      format.html # index.html.erb
      format.mobile { render json: @babies } 
      format.json { render json: @babies }
    end
  end

  def last_24h_sleeptime
    @baby = Baby.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.mobile { render json: @baby.last_24h_sleeptime }
      format.json { render json: @baby.last_24h_sleeptime }
    end
  end


end
