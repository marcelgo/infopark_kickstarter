$ ->
  timeout = undefined
  savedContent = undefined
  originalContent = ''

  saveAction = (buttonName, buttonDom, buttonObject) ->
    @getBox().addClass('saving')
    saveContents(@, true)

  cancelAction = (buttonName, buttonDom, buttonObject) ->
    cancelEditing(@)

  redactorOptions = () ->
    customButtonDefinition =
      saveButton:
        title: 'Save'
        callback: saveAction
      cancelButton:
        title: 'Cancel'
        callback: cancelAction

    return {} =
      buttonsCustom: customButtonDefinition,
      focus: true
      convertDivs: false
      linebreaks: true
      buttons: ['saveButton', 'cancelButton',
        '|', 'formatting',
        '|', 'bold', 'italic', 'deleted', 'underline',
        '|', 'unorderedlist', 'orderedlist',
        '|', 'table', 'link',
        '|', 'fontcolor', 'backcolor',
        '|', 'html'
      ]
      removeEmptyTags: false
      linebreaks: false
      initCallback: (_) ->
        originalContent = @get()
      changeCallback: (_) ->
        autosaveAction(@)
      blurCallback: (_) ->
        saveContents(@)
      keyupCallback: (event) ->
        key = event.keyCode || event.which

        if key == 27
          cancelEditing(@)
        else
          autosaveAction(@)
      pasteAfterCallback: (html) ->
        autosaveAction(@)
        html

  saveContents = (editor, closeEditor = false) ->
    content = editor.get()
    if savedContent != content
      editor.$element.infopark('save', content).done( ->
        savedContent = content
        # close editor after safe
        if closeEditor
          editor.destroy()
      ).fail( ->
        editor.getBox().removeClass('saving')
      )
    else
      # close editor in case of no save needed
      if closeEditor
        editor.destroy()

  cancelEditing = (editor) ->
    editor.set(originalContent)
    saveContents(editor)
    editor.destroy()

  autosaveAction = (editor) ->
    if timeout
      clearTimeout(timeout)
    timeout = setTimeout ( ->
      saveContents(editor)
    ), 3000

  htmlFields = (content, fieldType) ->
    content.find("[data-ip-field-type='html']")

  addOnclickRedactorHandlers = (content) ->
    htmlFields(content).on 'click', (event) ->
      event.preventDefault()
      cmsField = $(this)

      unless cmsField.data('redactor')
        cmsField.html(cmsField.infopark('content') || '')
        cmsField.redactor(redactorOptions())

  infopark.on 'editing', ->
    addOnclickRedactorHandlers($('body'))

  infopark.on 'new_content', (domElement) ->
    addOnclickRedactorHandlers($(domElement))
