$(window).on('turbolinks:load', ->
  $('#range').on('input', ->
    vote = +$('#range').val()
    url = $('#rating a').attr('href').replace(/\d+$/, vote)
    $('#rating a').html(vote)
    $('#rating a').attr('href', url)
  )
)
