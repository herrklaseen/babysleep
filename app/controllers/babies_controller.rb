class BabiesController < ApplicationController
  before_filter :set_parent_id

  def index
    @navigation = [ {:text => t('navigation.about'), :url => url_for(about_path)},
                    {:text => t('navigation.log_out'), 
                     :url => url_for(destroy_user_session_path), 
                     :method => :delete} ]

    @babies = Baby.find_all_by_parent_id(user_session[:parent_id])

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end

  def last_24h_sleeptime
    @navigation = [ {:text => t('navigation.about'), :url => url_for(about_path)},
                    {:text => t('navigation.log_out'), 
                     :url => url_for(destroy_user_session_path), 
                     :method => :delete},
                    {:text => t('navigation.choose_baby'), :url => url_for(babies_path)}]

    @baby = Baby.find(params[:id])

    @navigation.push( { :text => t('navigation.edit_sleeptimes'), 
                        :url => url_for(baby_sleeptimes_path(@baby)) } )

    respond_to do |format|
      format.html 
      format.json { render json: @baby.last_24h_sleeptime }
    end
  end

  def set_parent_id
    if (user_session[:parent_id])
      return
    else
      user_session[:parent_id] = Parent.find_by_user_id(current_user[:id])
    end
  end

end
