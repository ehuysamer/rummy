# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.card.selectable:not(._back)').on "click", (event) ->
    $(event.currentTarget).toggleClass("chosen");
    $('input[type=checkbox][value="' + $(event.currentTarget).attr('name') + '"]').prop('checked', $(event.currentTarget).hasClass('chosen'))
