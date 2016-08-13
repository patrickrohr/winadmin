class GamedaysController < ApplicationController
  authorize_resource
  
  def new
    @gameday_set = GamedaySet.new
  end

  def create_many
    #raise gamedayset_params.inspect
    @gameday_set = GamedaySet.new(gamedayset_params)
    if @gameday_set.save
      redirect_to({ action: :index }, success: t(:object_created))
    else
      flash.now.alert = t(:object_create_failed)
      render :new
    end
  end

  def edit
    @gameday = Gameday.find(params[:id])
  end

  def update
    update_action(Gameday, gameday_params)
  end

  def index
    @gamedays = Gameday.order(date: :asc)
  end

  def destroy
    destroy_action(Gameday)
  end


  private
  def gameday_params
    params.require(:gameday).permit(:date, :location)
  end

  def gamedayset_params
    params.require(:gameday_set).permit(:league_id, gamedays_attributes: [:date, :location, :league_id])
  end
end
