class GamedaysController < ApplicationController
  def new
  end

  def create
    dates = params[:gamedaydate]
    locations = params[:gamedayplace]
    league_id = params[:Team][:league_id]

    error = false
    if not dates.nil? and dates.size == locations.size #TODO write validations so this does not need to be checked
      dates.each_index do |i|
        gd = Gameday.new
        gd.date = dates[i] # TODO: check if this works, no day month mix ups
        gd.location = locations[i]
        gd.league_id = league_id
        unless gd.save
          error = true # an error has happened with one of the gamedays, still keep going
        end
      end
    else
      error = true
    end
    if error
      redirect_to({ action: :index }, alert: t(:object_create_failed))
    else
      redirect_to({ action: :index }, success: t(:object_created))
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
end
