class BabiesController < ApplicationController
  def start
    respond_to do |format|
      format.html 
    end
  end


  # GET /babies
  # GET /babies.json
  def index
    @navigation = [ {:text => "About", :url => "/about"},
                    {:text => "Log out", :url => url_for(logout_path)} ]

    @babies = Baby.find_all_by_parent_id(session[:parent_id])

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end

  def last_24h_sleeptime
    @navigation = [ {:text => "About", :url => "/about"},
                    {:text => "Log out", :url => url_for(logout_path)},
                    {:text => "Edit sleeptimes", :url => url_for(:action => 'index', :controller => 'sleeptimes') } ]

    @baby = Baby.find(params[:id])

    respond_to do |format|
      format.html 
      format.json { render json: @baby.last_24h_sleeptime }
    end
  end


end
