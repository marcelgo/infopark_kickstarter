root = exports ? this

root.Tour =
  modalId: 'tour-modal'
  wrapper: -> $('#' + this.modalId)

  # Start the tour by providing a remote content url. Ajax is used to load the
  # content from that url and placing it inside the tour modal.
  start: (url) ->
    if this.wrapper().length == 0
      this.createModal()

    this.wrapper().modal
      'remote': url

    return

  createModal: () ->
    modal = $('<div></div>')
      .attr('id', this.modalId)
      .attr('tabindex', -1)
      .addClass('tour modal hide fade')

    body = $('<div></div>')
      .addClass('modal-body')
      .appendTo(modal)

    modal.appendTo('body')

    return