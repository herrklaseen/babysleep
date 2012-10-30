class SleeptimesController < ApplicationController

  def index 
    @navigation = [ {:text => t('navigation.about'), 
                     :url => "/about"},
                    {:text => t('navigation.log_out'), 
                     :url => url_for(logout_path)} ]

    @sleeptimes = Sleeptime.find_all_by_baby_id(params[:baby_id])
    @baby = Baby.find_by_id(params[:baby_id])

    @navigation.push({:text => t('navigation.last_24h_sleeptime_for') << 
                               @baby.name.rjust(@baby.name.length + 1), 
                     :url => url_for(last_24h_sleeptime_baby_path(@baby))})

    respond_to do |format|
      format.html
      format.json { render json: @sleeptimes }
    end    
  end

  def new
    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.new(:baby => @baby)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end


  def create
    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.make_instance(params[:start], params[:end], @baby)
    @sleeptime.save
    respond_to do |format|
      format.html { redirect_to last_24h_sleeptime_baby_path(@baby)}
      format.json { render json: @sleeptimes }
    end
  end  

  def edit
    @navigation = [ {:text => t('navigation.about'), :url => "/about"},
                {:text => t('navigation.log_out'), :url => url_for(logout_path)}]

    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.find_by_id(params[:id])

    @navigation.push( { :text => t('navigation.back_to_sleeptimes'), 
                        :url => url_for(baby_sleeptimes_path(@baby)) },
                        :text => t('navigation.last_24h_sleeptime_for') << 
                                 @baby.name.rjust(@baby.name.length + 1), 
                        :url => url_for(baby_sleeptimes_path(@baby)) )

    respond_to do |format|
      format.html
      format.json { render json: @sleeptime }
    end
  end

  def update
    @baby = Baby.find_by_id(params[:baby_id])
    @sleeptime = Sleeptime.find_by_id(params[:id])
    @sleeptime.starttime = params[:start]
    @sleeptime.endtime = params[:end]
    respond_to do |format|
      format.html { redirect_to baby_sleeptimes_path }
      format.json { render json: @sleeptime }
    end
  end

  def destroy
    @sleeptime = Sleeptime.find_by_id(params[:id])
    @sleeptime.destroy
    respond_to do |format|
      format.html { redirect_to baby_sleeptimes_path }
      format.json { render json: @sleeptime }
    end
  end

end
