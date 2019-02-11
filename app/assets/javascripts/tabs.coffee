$(window).on('turbolinks:load load', ->
  $('.tab').on('click', (event) ->
    if (event.target.id == 'comments-tab')
      $('#book-history').removeClass('active-tab-content')
      $('#book-comments').addClass('active-tab-content')
      $('#history-tab').removeClass('active-tab')
      $('#comments-tab').addClass('active-tab')
    else if (event.target.id == 'history-tab')
      $('#book-history').addClass('active-tab-content')
      $('#book-comments').removeClass('active-tab-content')
      $('#history-tab').addClass('active-tab')
      $('#comments-tab').removeClass('active-tab')
  )
)