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

  carouselItems = document.querySelectorAll('.carousel-point')
  for i in carouselItems
    $(i).height(max)
)

$(document).on("load turbolinks:load", ->
  # Carousel navigation buttons
  currentPoint = ->
    for i in [0...points.length]
      if $(points[i]).hasClass('active')
        return i

  points = document.querySelectorAll('.carousel-point')
  current = currentPoint()

  right = ->
    requestAnimationFrame(->
      $(".right").css("pointer-events", "none")
      $(points[current]).removeClass('active')
      $(points[current++]).on('transitionend', ->
        current = if current >= points.length then 0 else current
        $(points[current]).addClass('active')
        $(points[current]).on('transitionend', ->
          $(".right").css("pointer-events", "auto")
        )
      )
    )

  left = ->
    requestAnimationFrame(->
      $(".left").css("pointer-events", "none")
      $(points[current]).removeClass('active')
      $(points[current--]).on('transitionend', ->
        current = if current < 0 then points.length - 1 else current
        $(points[current]).addClass('active')
        $(points[current]).on('transitionend', ->
          $(".left").css("pointer-events", "auto")
        )
      )
    )

  $('.right').on('click', ->
    right()
  )

  $('.left').on('click', ->
    left()
  )

  interval = setInterval(->
    right()
  , 7000)

  $('#carousel').on('click', ->
    clearInterval(interval)
  )
)
