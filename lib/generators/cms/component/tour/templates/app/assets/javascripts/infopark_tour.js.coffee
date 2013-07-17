jQuery.fn.center = ->
  if (this.length == 1)
    this.css(
      marginLeft: -this.innerWidth() / 2,
      marginTop: -this.innerHeight() / 2,
      left: '50%',
    )

root = exports ? this

root.InfoparkTour =
  overlay: -> $('#ip_tour_overlay')
  modal: -> $('#ip_tour_modal')

  init: () ->
    self = this

    $('.ip_sub_nav_vertical li a').on 'click', (event) ->
      event.preventDefault()
      $(this).tab('show')

    $(window).resize ->
      self.modal().find('.show').center()

    self.overlay().on 'click', () ->
      self.hide()

    return

  hide: ->
    this.overlay().removeClass('show')
    this.modal().removeClass('show')

    $(window).unbind 'keyup.infopark_tour'

    return

  show: ->
    self = this

    self.overlay().addClass('show')
    self.modal().addClass('show')
    self.modal().center()

    $(window).on 'keyup.infopark_tour', (event) ->
      if (event.which == 27)
        self.hide()

    return