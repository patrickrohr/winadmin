class ResultsController < ApplicationController
  def new
  end

  def create
  end

  def collection_create
    sport_id = params[:sport][:id]
    Game.add_results(params[:score])
    redirect_to({ action: :index, filter: sport_id}, { success: t(:object_updated)})
  end

  def index
    @leagues = League.where(sport_id: request[:filter]).order(number: :asc)
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end


  private
  def result_params
    #params.require(:team).permit(:name, :display_name, :email, :sport_id, :league_id, :sport_id)
  end
end
