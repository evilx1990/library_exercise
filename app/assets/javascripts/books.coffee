$(window).on("load turbolinks:load resize", ->
  # Carousel height
  carouselImages =  document.querySelectorAll('.carousel-content .book-image')
  carouselDesc = document.querySelectorAll('.carousel-content .book-description')

  # Find point with max height && get him value
  maxHeightImg = $(carouselImages[0]).height()
  for i in [0..carouselImages.length - 1]
    if maxHeightImg < $(carouselImages[i + 1]).height()
      maxHeightImg = $(carouselImages[i + 1]).height()

  maxHeightDesc = $(carouselDesc[0]).height()
  for i in [0..carouselDesc.length - 1]
    if maxHeightDesc < $(carouselDesc[i + 1]).height()
      maxHeightDesc = $(carouselDesc[i + 1]).height()

  max = if maxHeightImg > maxHeightDesc
          maxHeightImg
        else
          maxHeightDesc

  # Set new height for all points
  $('.carousel-content').height(max)

  carouselItems = document.querySelectorAll('.carousel-slide')
  for i in carouselItems
    $(i).height(max)
)

$(document).on("load turbolinks:load", ->
  # Carousel navigation buttons
  currentPoint = ->
    for i in [0...points.length]
      if $(points[i]).hasClass('active-slide')
        return i

  points = document.querySelectorAll('.carousel-slide')
  current = currentPoint()


  $('.right').on('click', ->
    requestAnimationFrame(->
      $(points[current]).removeClass('active-slide')
      $(points[current++]).on('transitionend', ->
        current = if current >= points.length then 0 else current
        $(points[current]).addClass('active-slide')
        $(points[current]).on('transitionend', ->
        )
      )
    )
  )

  $('.left').on('click', ->
    requestAnimationFrame(->
      $(points[current]).removeClass('active-slide')
      $(points[current--]).on('transitionend', ->
        current = if current < 0 then points.length - 1 else current
        $(points[current]).addClass('active-slide')
        $(points[current]).on('transitionend', ->
        )
      )
    )
  )
)

$(window).on('turbolinks:load', ->
  $("input[value='Create comment']").attr('disabled', true)

  $("#comment_message").on('input', ->
    if $("#comment_message").val() == ''
      $("input[value='Create comment']").attr('disabled', true)
    else
      $("input[value='Create comment']").attr('disabled', false)
  )
)
