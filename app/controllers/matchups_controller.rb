class MatchupsController < ApplicationController

  def new
  end

  def create #generate matchups, damn i need to put this crap in models
    league = League.find params[:league][:id]
    used_teams = []

    league.teams.each do |team1| # generate matchups for EVERY team in leagues
      used_teams << team1.id # indicates that this teams matchups have already been created

      league.teams.each do |team2| # should loop through opponents (and filter out used_teams)
        next if used_teams.include?(team2.id)
        game = Game.create team_1_id: team1.id, team_2_id: team2.id, league_id: league.id
        unless game.errors.empty?
          redirect_to(action: :index , alert: t(:object_create_failed))
        end
      end
    end

    redirect_to(action: :index , success: t(:object_created))
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
  end

  def reverse
    game = Game.find params[:id]
    game.update_attributes(team_1_id: game.team_2_id, team_2_id: game.team_1_id)

    if game.errors.empty?
      redirect_to matchups_path, success: t(:object_updated)
    else
      redirect_to matchups_path, alert: t(:object_update_failed)
    end
  end

  def destroy
    destroy_action(Game, filter: Game.find(params[:id]).league.sport_id)
  end


  private
  def game_params
    #params.require(:sport).permit(:name, :number_of_sets, :number_of_leagues)
  end
end
