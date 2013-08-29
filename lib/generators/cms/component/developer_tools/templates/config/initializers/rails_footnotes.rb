if defined?(Footnotes) && Rails.env.development?
  Footnotes.run!

  if defined?(InfoparkDashboard)
    require 'footnotes/notes/dashboard_note'

    Footnotes::Filter.notes += [:dashboard]
  end

  require 'footnotes/notes/obj_class_note'
  require 'footnotes/notes/dev_center_note'
  require 'footnotes/notes/help_note'

  Footnotes::Filter.notes += [
    :obj_class,
    :dev_center,
    :help,
  ]
end