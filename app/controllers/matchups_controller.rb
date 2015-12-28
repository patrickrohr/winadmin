class MatchupsController < ApplicationController
  authorize_resource :league, :game

  def new
  end

  def create_many
    @game_set = GameSet.new(gameset_params)
    if @game_set.save
      redirect_to({ action: :index }, success: t(:object_created))
    else
      redirect_to({ action: :index }, alert: t(:object_create_failed))
    end
  end

  def save
    params[:date].each do |game_id, gameday_id|
      game = Game.find(game_id)
      game.update_attributes(gameday_id: gameday_id, order: params[:order][game_id])
      redirect_to(matchups_path, alert: t(:object_create_failed)) unless game.errors.empty?
    end
    redirect_to matchups_path, success: t(:object_created)
  end

  def edit
  end

  def update
  end

  def index
    sport_id = sport_id_filter_default request[:filter]
    @leagues = League.where(sport_id: sport_id).order(:number)
    @game_set = GameSet.new
    @game_set.games = Game.where(league_id: @leagues)
  end

  def destroy # TODO
    destroy_action(Game, filter: Game.find(params[:id]).league.sport_id)
  end


  private
  def game_params
    #params.require(:game).permit(:gameday_id, :team_1_number, :team_2_number)
  end

  def gameset_params
    params.require(:game_set).permit(games_attributes: [:id, :gameday_id, :team_1_number, :team_2_number])
  end
end
