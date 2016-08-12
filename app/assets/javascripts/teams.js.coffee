# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


#$(document).on 'page:change', -> #turbolinks dom ready fix
#  $('#team_league_id, #Team_league_id').prop("disabled", true)
#  leagues = $('#team_league_id, #Team_league_id').html()
#  $('#team_sport_id, #Team_sport_id').change ->
#    sport = $('#team_sport_id :selected, #Team_sport_id :selected').text()
#    options = $(leagues).filter("optgroup[label='#{sport}']").html()
#    if options
#      $('#team_league_id, #Team_league_id').html(options)
#      $('#team_league_id, #Team_league_id').prop("disabled", false)
#    else
#      $('#team_league_id, #Team_league_id').empty()
#      $('#team_league_id, #Team_league_id').prop("disabled", true)