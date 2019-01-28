$(document).on "turbolinks:load", ->
  $('.toggle').on 'click', ->
    $('aside').addClass('switched-bar')
    $('nav, article').addClass('switched-main')
    $('nav, article').on 'transitionend', ->
      $('nav, article').on 'click', ->
        $('aside').removeClass('switched-bar')
        $('nav, article').removeClass('switched-main')
        $('nav, article').on 'transitionend', ->
          $('nav, article').unbind('click')
