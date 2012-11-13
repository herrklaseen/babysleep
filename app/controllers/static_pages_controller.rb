class StaticPagesController < ApplicationController
  skip_before_filter :authenticate_user!

  def home
    if (user_signed_in?)
      @navigation = [ {:text => t('navigation.about'), :url => url_for(about_path)},
                      {:text => t('navigation.log_out'), 
                       :url => url_for(destroy_user_session_path), 
                       :method => :delete},
                      {:text => t('navigation.choose_baby'), :url => url_for(babies_path)} ]
    else
      @navigation = [ {:text => t('navigation.about'), :url => url_for(about_path)},
                      {:text => t('navigation.log_in'), :url => url_for(new_user_session_path)} ]
    end

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end
  
  def about
    if (user_signed_in?)
      @navigation = [ {:text => t('navigation.home'), :url => url_for(home_path)},
                      {:text => t('navigation.log_out'), 
                       :url => url_for(destroy_user_session_path), 
                       :method => :delete},
                      {:text => t('navigation.choose_baby'), :url => url_for(babies_path)} ]
    else
      @navigation = [ {:text => t('navigation.home'), :url => url_for(home_path)},
                    {:text => t('navigation.log_in'), :url => url_for(new_user_session_path)} ]
    end

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end

  def help
  end

  private

end
