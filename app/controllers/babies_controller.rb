class BabiesController < ApplicationController
  # GET /babies
  # GET /babies.json
  def index
    @babies = Baby.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @babies }
    end
  end

  def sleeptime
    @babies = Baby.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @babies }
    end
  end


end
