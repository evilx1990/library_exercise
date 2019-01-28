$(document).on "turbolinks:load", ->
  $(window).on 'load resize', ->
    carouselImages =  document.querySelectorAll('.carousel-item .book-image')
    carouselDesc = document.querySelectorAll('.carousel-item .book-description')

#   Find slide with max height && get him value
    maxHeightImg = $(carouselImages[0]).height()
    for i in [0...carouselImages.length - 1]
      if maxHeightImg < $(carouselImages[i + 1]).height()
        maxHeightImg = $(carouselImages[i + 1]).height()

    maxHeightDesc = $(carouselDesc[0]).height()
    for i in [0...carouselDesc.length - 1]
      if maxHeightDesc < $(carouselDesc[i + 1]).height()
        maxHeightDesc = $(carouselDesc[i + 1]).height()

    max = if maxHeightImg > maxHeightDesc
            maxHeightImg
          else
            maxHeightDesc

#   Set new height for all slides
    carouselItems = document.querySelectorAll('.carousel-item')
    for i in carouselItems
      $(i).height(max)
