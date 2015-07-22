class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
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
    params.require(:team).permit(:name, :display_name, :email)
  end
end
