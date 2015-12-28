# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

order = new Array() # order[DATE][GAME_ID] = ORDER_NUMBER
old_dates = new Array()

$(document).on 'page:change', -> new AddGameToGameday 'addgame'

class AddGameToGameday
  constructor: (className) ->
    elements = $(".#{className}")
    elements.on 'click', @addForm

  addForm: (event) ->
    event.preventDefault()
    gameday_id = $(@).data("id")
    tmp = JST['matchups/game'](gameday_id: gameday_id)
    $("\##{gameday_id}").append(tmp)
  