class BabiesController < ApplicationController
  # GET /babies
  # GET /babies.json
  def index
    @babies = Baby.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.mobile {render }
    #   format.json { render json: @babies }
    # end
  end

  def last_24h_sleeptime
    @baby = Baby.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @baby.last_24h_sleeptime }
    end
  end


end
