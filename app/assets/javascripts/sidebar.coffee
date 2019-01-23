$(document).on "turbolinks:load", ->
  $('.sidebar').on 'click', ->
    $("#sidebar").toggleClass('toggler-bar')
    $('#content').toggleClass('toggler-content')