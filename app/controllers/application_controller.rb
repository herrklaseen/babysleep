class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, :set_user_time_zone

  helper_method :set_user_time_zone

  def after_sign_in_path_for(resource)
    babies_path
  end

  private

  def set_user_time_zone
    logger.ap current_user
    if (user_signed_in?)
      if(user_session[:time_zone])
        Time.zone = user_session[:time_zone]
      else
        user_session[:time_zone] = ActiveSupport::TimeZone.[](current_user[:session_tz_offset])
        Time.zone = user_session[:time_zone]
      end
    else
      Time.zone = config.time_zone
    end
    logger.ap("Session time zone is #{Time.zone}")
  end


end
