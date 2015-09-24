class ResultsController < ApplicationController

  def new
  end

  def create
  end

  def collection_create
    Game.add_results(params[:score])
    redirect_to results_path, success: t(:object_updated)
  end

  def index
    sport_id = sport_id_filter_default request[:filter]
    @leagues = League.where(sport_id: sport_id).order(number: :asc)
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
