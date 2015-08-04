class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    create_action(Team, team_params, filter: params[:team][:sport_id])
  end

  def index
    sport_id = sport_id_filter_default request[:filter]
    @leagues = League.where(sport_id: sport_id).order(number: :asc)
  end

  def show
    @team = Team.find(params[:id])
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    update_action(Team, team_params, filter: params[:team][:sport_id])
  end

  def destroy
    destroy_action(Team, filter: Team.find(params[:id]).sport_id)
  end


  private
  def team_params
    params.require(:team).permit(:name, :display_name, :email, :sport_id, :league_id, :sport_id)
  end
end
