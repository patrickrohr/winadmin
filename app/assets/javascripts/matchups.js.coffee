# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

order = new Array() # order[DATE][GAME_ID] = ORDER_NUMBER
old_dates = new Array()

$(document).on 'page:change', -> 
  $('input[type=radio]').on 'change', -> #when radio changes, update order
    object_id = matchObjectId(this.name)
    $('#order_' + object_id).val(99)

    #is there anything lower with the same date? no, go to 1, yes
    $(':radio[name="date[' + object_id + ']"]').each -> # selector should contain all dates
      i = 1 # counter
      t = $(':radio[value="' + this.value + '"]:checked').sort((a,b) ->
        val_a = $('#order_' + matchObjectId(a.name)).val()
        val_b = $('#order_' + matchObjectId(b.name)).val()
        return true if val_a == ''
        return false if val_b == ''
        parseInt(val_a) > parseInt(val_b)
      )
      t.each ->
        obj = $('#order_' + matchObjectId(this.name))
        obj_tag = $('#order_tag_' + matchObjectId(this.name))
        obj.val(i)
        obj_tag.html(i)
        i++

matchObjectId = (name) ->
  matches = name.match(/\[(.*?)\]/)
  object_id = matches[1]