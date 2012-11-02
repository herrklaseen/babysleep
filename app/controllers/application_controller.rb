class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_user_time_zone

  logger.ap Time.zone

  helper_method :set_user_time_zone

  private

  def set_user_time_zone
    if (session[:user_time_zone])
      Time.zone = session[:user_time_zone]
    else
      Time.zone = config.time_zone
    end
  end


end
