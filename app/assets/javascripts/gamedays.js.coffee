# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

dp = $.fn.datepicker.defaults
dp.format = "dd/mm/yyyy";
dp.multidate = true;
dp.disableTouchKeyboard = true;
dp.language = 'de';
dp.todayHighlight = true;


$ -> new DateSelector('gameday-datepicker')
$(document).on 'page:change', -> new DateSelector('gameday-datepicker')


Array::valueOfByElement = () ->
  @.map (element) ->
    if element instanceof Date
      element.valueOf()
    else
      element.toString()

Array::diff = (arr) ->
  arr = arr.valueOfByElement()
  @.filter (element) ->
    arr.indexOf(element.valueOf()) < 0



class DateSelector
  constructor: (@datepickerId) ->
    id = "\##{datepickerId}"
    dp = $(id).datepicker()
    dp.on 'changeDate', @change
    @dropdown = $('#team_league_id')
    @dropdown.on 'change', @selectLeague
    $('#team_sport_id').on 'change', @selectLeague
    @dates = []

  change: (event) => # decides if date has been added or removed
    new_dates = event.dates
    if new_dates.length > @dates.length
      @add(new_dates.diff(@dates)[0])
    else if new_dates.length < @dates.length
      @remove(@dates.diff(new_dates)[0])
    @dates = new_dates # maybe consider updating @dates with new_dates before calling add/remove

  add: (date) ->
    date = { obj: date, add: true }
    @render(date)

  remove: (date) ->
    date = { obj: date, add: false }
    @render(date)

  render: (date) ->
    id = date.obj.valueOf()
    if date.add
      tmp = JST['gamedays/gameday'](id: id, league_id: @dropdown.val(), date: date.obj.toLocaleDateString("de-CH"))
      $('#gameday-set').append(tmp)
    else
      $("[id='#{id}']").remove()

  selectLeague: (event) => # sets league_id straight in every leagues hidden field, way easier to insert data
    $('[name="gameday_set[gamedays_attributes][][league_id]"]').val(@dropdown.val())