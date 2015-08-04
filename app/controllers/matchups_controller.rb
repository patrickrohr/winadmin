class MatchupsController < ApplicationController
  def new
  end

  def create
    reverse = request[:reverse]
    sport_id = params[:sport][:id]
    error = false

    leagues = League.where(sport_id: sport_id).order(number: :asc)
    leagues.each do |league| # loop through leagues so there arent any mixups
      used_teams = []

      teams = Team.where(league_id: league.id)
      teams.each do |team1| # generate matchups for EVERY team in leagues
        used_teams << team1.id # indicates that this teams matchups have already been created

        teams.each do |team2| # should loop through opponents (and filter out used_teams)
          next if used_teams.include?(team2.id)
          game = Game.new

          if reverse == '1' # for creating reversed rounds
            game.team_2_id = team1.id
            game.team_1_id = team2.id
          else
            game.team_1_id = team1.id
            game.team_2_id = team2.id
          end
          game.league_id = league.id
          unless game.save
            error = true
          end
        end
      end
    end
    unless error
      redirect_to({ action: :index, filter: sport_id}, { success: t(:object_created)})
    else
      redirect_to({ action: :index, filter: sport_id }, alert: t(:object_create_failed))
    end
  end

  def save
    params[:date].each do |game_id, gameday_id|
      game = Game.find(game_id)
      game.gameday_id = gameday_id
      unless game.save then error = true end
    end

    if error ||= false
      redirect_to({ action: :index, filter: params[:sport][:id] }, alert: t(:object_create_failed))
    else
      redirect_to({ action: :index, filter: params[:sport][:id] }, success: t(:object_created))
    end
  end

  def edit
  end

  def update
  end

  def index
    sport_id = sport_id_filter_default request[:filter]
    @leagues = League.where(sport_id: sport_id).order(number: :asc)
  end

  def destroy
    destroy_action(Game, filter: Game.find(params[:id]).league.sport_id)
  end


  private
  def game_params
    #params.require(:sport).permit(:name, :number_of_sets, :number_of_leagues)
  end
end
