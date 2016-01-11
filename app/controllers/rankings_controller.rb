class RankingsController < ApplicationController
  authorize_resource :game, :parent => false

  def index
    sport_id = sport_id_filter_default request[:filter]
    @leagues = League.where(sport_id: sport_id).order(:number)
  end

  def create
    sport_id = user_session.get(:filter_sport_id) # okay that's how mistakes happen.... TODO!!!
    sport = Sport.find(sport_id)
    team_points = Hash.new(0)
    team_games = Hash.new(0)
    sport.leagues.each do |league|
      league.games.each do |game| #iterate through EVERY game in EVERY league, calculate points, set it in team table
        if game.tie == false and not game.winner_id.nil? # no tie and winner exists
          team_points[game.winner_id] += 2
          team_games[game.team_1_id] += 1
          team_games[game.team_2_id] += 1
        elsif game.tie == true
          team_points[game.team_1_id] += 1
          team_points[game.team_2_id] += 1
          team_games[game.team_1_id] += 1
          team_games[game.team_2_id] += 1
        end # else, game has not been played yet
      end

      league.teams.each do |team|
        team.points = team_points[team.id] #|| 0 should work without this
        team.game_count = team_games[team.id]
        team.save
      end
    end
    redirect_to rankings_path, success: t(:object_created)
  end
end
