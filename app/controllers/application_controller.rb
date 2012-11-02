class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter do 
    set_user_time_zone
  end

  helper_method :set_user_time_zone

  private

  def set_user_time_zone
    if (session[:user_time_zone])
      Time.zone = session[:user_time_zone]
    else
      Time.zone = config.user_time_zone
    end
  end


end
