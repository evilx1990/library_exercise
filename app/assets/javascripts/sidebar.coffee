$(document).on "turbolinks:load", ->
  $('.toggle').on 'click', ->
    $("#sidebar").addClass('switched-bar')
    $('#content').addClass('switched-content')
    $('#content').on 'transitionend', ->
      $(this).on 'click', ->
        $("#sidebar").removeClass('switched-bar')
        $(this).removeClass('switched-content')
        $(this).on 'transitionend', ->
          $(this).unbind('click')
