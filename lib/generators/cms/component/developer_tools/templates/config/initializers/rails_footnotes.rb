if defined?(Footnotes) && Rails.env.development?
  Footnotes.run!

  require 'footnotes/notes/obj_class_note'
  require 'footnotes/notes/dev_center_note'
  require 'footnotes/notes/help_note'
  require 'footnotes/notes/dashboard_note'

  Footnotes::Filter.notes += [:obj_class, :dev_center, :help, :dashboard]
end