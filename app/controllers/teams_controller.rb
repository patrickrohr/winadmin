class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    create_action(Team, team_params)
  end

  def index
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
  def team_params
    params.require(:team).permit(:name, :display_name, :email, :sport_id, :league_id)
  end
end
