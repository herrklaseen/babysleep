class BabiesController < ApplicationController
  # GET /babies
  # GET /babies.json
  def index
    @navigation = [ {:text => t('navigation.about'), :url => "/about"},
                    {:text => t('navigation.log_out'), :url => url_for(logout_path)} ]

    @babies = Baby.find_all_by_parent_id(session[:parent_id])

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end

  def last_24h_sleeptime
    @user_time_zone = session[:user_time_zone]
    @set_time_zone = Time.zone
    @navigation = [ {:text => t('navigation.about'), :url => "/about"},
                    {:text => t('navigation.log_out'), :url => url_for(logout_path)},
                    {:text => t('navigation.choose_baby'), :url => url_for(babies_path)}]

    @baby = Baby.find(params[:id])

    @navigation.push( { :text => t('navigation.edit_sleeptimes'), 
                        :url => url_for(baby_sleeptimes_path(@baby)) } )

    respond_to do |format|
      format.html 
      format.json { render json: @baby.last_24h_sleeptime }
    end
  end

end
