class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!, :set_session_tz_offset_for_user

  helper_method :set_user_time_zone, :set_session_tz_offset_for_user

  def after_sign_in_path_for(resource)
    babies_path
  end

  private

  def set_user_time_zone
    if (user_signed_in?)
      if(user_session[:time_zone])
        Time.zone = user_session[:time_zone]
      else
        user_session[:time_zone] = ActiveSupport::TimeZone.[](current_user.session_tz_offset)
        Time.zone = user_session[:time_zone]
      end
    else
      Time.zone = config.time_zone
    end
  end

  def set_session_tz_offset_for_user
    Warden::Manager.after_authentication do |user, auth, opts|
      if (params[:user])
        user.session_tz_offset = params[:user][:session_tz_offset]
        user.save
      end
    end
  end

end
