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
    return -1

  points = document.querySelector('.carousel-slide')

  changeSlide = (direction) ->
    current = currentPoint()
    if current == -1
      return false

    $(points[current]).removeClass('active-slide')
    $(points[current]).addClass('current-slide')
    $(points[current]).on('transitionend', ->
      if event.propertyName == 'opacity'
        $(points[current]).removeClass('current-slide')

        if direction == 'right'
          current = if ++current >= points.length then 0 else current
        else if direction == 'left'
          current = if --current < 0 then points.length - 1 else current

        $(points[current]).addClass('next-slide')
        $('.next-slide').on('transitionend', ->
          if event.propertyName == 'opacity'
            $(points[current]).removeClass('next-slide')
            $(points[current]).addClass('active-slide')
            $(this).off('transitionend')
        )
        $(this).off('transitionend')
    )

  $('.right').on('click', ->
    changeSlide('right')
  )

  $('.left').on('click', ->
    changeSlide('left')
  )
)
