$(window).on("load turbolinks:load resize", ->
  # Carousel height
  carouselImages =  $('.carousel-content .book-image')
  carouselDesc = $('.carousel-content .book-description')

  # Find point with max height && get him value
  maxHeightImg = $(carouselImages[0]).height()
  carouselImages.each(->
    if maxHeightImg < $(this).height()
      maxHeightImg = $(this).height()
  )

  maxHeightDesc = $(carouselDesc[0]).height()
  carouselDesc.each(->
    if maxHeightDesc < $(this).height()
      maxHeightDesc = $(this).height()
  )

  max = if maxHeightImg > maxHeightDesc then maxHeightImg else maxHeightDesc

  # Set new height for all points
  $('.carousel-content').height(max)

  carouselItems = $('.carousel-slide')
  $(carouselItems).each(->
    $(this).height(max)
  )
)

$(document).on("load turbolinks:load", ->
  # Carousel navigation buttons

  currentPoint = ->
    point = -1
    $('.carousel-slide').each((index)->
      if $(this).hasClass('active-slide')
        point = index
    )
    console.log(point)
    return point


  changeSlide = (direction) ->
    current = currentPoint()
    if current == -1
      return false

    points = $('.carousel-slide')
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
