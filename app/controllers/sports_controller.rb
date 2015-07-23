class SportsController < ApplicationController
  def new
    @sport = Sport.new
  end

  def create
    create_action(Sport, sport_params)
  end

  def edit
    @sport = Sport.find params[:id]
  end

  def update
    update_action(Sport, sport_params)
  end

  def index
    @sports = Sport.all
  end

  def destroy
    destroy_action(Sport)
  end


  private
  def sport_params
    params.require(:sport).permit(:name, :number_of_sets, :number_of_leagues)
  end
end
