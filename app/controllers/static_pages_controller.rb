class StaticPagesController < ApplicationController
  def home
    @navigation = [ {:text => t('navigation.about'), :url => "/about"} ]

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end

  def help
  end
end
