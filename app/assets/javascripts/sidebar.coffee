$(document).on("turbolinks:load", ->
  $('.toggle').on('click', ->
    $('aside').addClass('switched-bar')
    $('nav, article, footer').addClass('switched-main')
    $('nav, article, footer').on 'transitionend', ->
      $('nav, article, footer').on 'click', ->
        $('aside').removeClass('switched-bar')
        $('nav, article, footer').removeClass('switched-main')
        $('nav, article, footer').on 'transitionend', ->
          $('nav, article, footer').unbind('click')
  )
  $('.sidebar-link').on('click', ->
    $('nav, article, footer').removeClass('switched-main')
    $('aside').removeClass('switched-bar')
  )
)