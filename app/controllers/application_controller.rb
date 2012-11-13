class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  helper_method :set_user_time_zone

  def after_sign_in_path_for(resource)
    babies_path
  end

  private

  def set_user_time_zone
    if (user_signed_in?)
        Time.zone = session[:user_time_zone]
    else
      Time.zone = config.time_zone
    end
  end


end
