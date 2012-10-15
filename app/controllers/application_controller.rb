class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_for_mobile

  private

  def mobile_device?
    if (session[:mobile_user_agent])
      session[:mobile_user_agent] == '1'
    else
      request.user_agent =~ /Mobile/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_user_agent] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
end
