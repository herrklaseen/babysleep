class BabiesController < ApplicationController
  before_filter :set_parent_id, :set_user_time_zone, :create_navigation

  def index
    @babies = Baby.find_all_by_parent_id(user_session[:parent_id])

    respond_to do |format|
      format.html 
      format.json { render json: @babies }
    end
  end

  def new
    @parent = Parent.find_by_id(params[:parent_id])
    @baby = Baby.new

    if (@parent)
      respond_to do |format|
        format.html 
      end
    else
      flash[:error] =  t('babies.sleeptimes.error.no_parent_with_id')
      render 'static_pages/error'
    end
  end

  def create
    @parent = Parent.find_by_id(params[:parent_id])
    birthdate = params[:date]
    birthdate_string = [ birthdate[:birth_year], birthdate[:birth_month], birthdate[:birth_day] ] * ", "
    date_of_birth = Date.strptime(birthdate_string, "%Y, %m, %d")
    @baby = Baby.new(:name => params[:baby][:name], 
                     :date_of_birth => date_of_birth)
    @baby.parent = @parent
    if (@baby.valid?)
      @baby.save
      redirect_to babies_path 
    else
      respond_to do |format|
        format.html { render 'new' } 
      end
    end
  end

  def last_24h_sleeptime
    @navigation.push({:text => t('navigation.choose_baby'), :url => url_for(babies_path)})

    @baby = Baby.find(params[:id])

    @navigation.push( { :text => t('navigation.edit_sleeptimes'), 
                        :url => url_for(baby_sleeptimes_path(@baby)) } )

    respond_to do |format|
      format.html 
      format.json { render json: @baby.last_24h_sleeptime }
    end
  end

  ## Before filters

  def set_parent_id
    if (user_session[:parent_id])
      return
    else
      user_session[:parent_id] = Parent.find_by_user_id(current_user[:id]).id
    end
  end

  def create_navigation
    @navigation = [ {:text => t('navigation.about'), :url => url_for(about_path)},
                    {:text => t('navigation.log_out'), :url => url_for(destroy_user_session_path), :method => :delete} ]
  end

end
