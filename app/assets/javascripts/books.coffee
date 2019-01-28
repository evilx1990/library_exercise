$(document).on("turbolinks:load", ->
  # Carousel height
  $(window).on('load resize', ->
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

  # Carousel navigation buttons
  currentPoint = ->
    for i in [0...points.length]
      if $(points[i]).hasClass('active')
        return i

  points = document.querySelectorAll('.carousel-point')
  current = currentPoint()

  $('.right').on('click', ->
    $(points[current++]).removeClass('active')
    current = if current >= points.length then 0 else current
    $(points[current]).addClass('active')
  )

  $('.left').on('click', ->
    $(points[current--]).removeClass('active')
    current = if current < 0 then points.length - 1 else current
    $(points[current]).addClass('active')
  )
)