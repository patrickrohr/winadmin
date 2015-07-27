# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

dp = $.fn.datepicker.defaults
dp.format = "dd/mm/yyyy";
dp.multidate = true;
dp.disableTouchKeyboard = true;
dp.language = 'de';
dp.todayHighlight = true;

dates_old = []

$(document).on 'page:change', ->
  $('#gameday-datepicker').datepicker().on 'changeDate', (e) ->
    $('#dates').val(e.format())
    dates_new = e.dates.map (x) ->
      if x isnt undefined
        return x.valueOf()
    console.debug('new: ' + dates_new)
    console.debug('old: ' + dates_old)
    if dates_new.length > dates_old.length # New date added
      addGameDay(e.date)
    else
      date = dates_old.diff(dates_new)
      removeGameDay(date[0])

    dates_old = dates_new

addGameDay = (date) ->
  id = date.valueOf()
  $('#gameday-content').append(partial).children().last().attr('id', id)
  $(".gamedaydate").last().val(date.toLocaleDateString("de-CH"))

removeGameDay = (dateOf) ->
  $('#' + dateOf).remove()