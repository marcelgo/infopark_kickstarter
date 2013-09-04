$(document).ready(function() {
  var save_action = function(button_name, button_dom, button_object) {
    var editor = this;

    editor.getBox().addClass('saving');

    if (!editor.opts.visual) {
      editor.toggle(true);
    }

    var value = editor.get();

    editor.$element.infopark('save', value).done(function() {
      editor.destroy();
    }).fail(function() {
      editor.getBox().removeClass('saving');
    });
  };

  var cancel_action = function(button_name, button_dom, button_object) {
    var editor = this;

    editor.set(editor.$element.infopark('content') || '');
    editor.destroy();
  };

  var redactor_options_for_type = function(type) {
    var default_options = {
      focus: true,
      convertDivs: false,
      buttonsCustom: {
        saveButton: {title: 'Save', callback: save_action},
        cancelButton: {title: 'Cancel', callback: cancel_action}
      }
    };

    var special_options = {};

    switch(type) {
      case 'string':
        special_options = {
          buttons: ['saveButton', 'cancelButton'],
          allowedTags: []
        };
        break;

      case 'html':
        special_options = {
          buttons: ['saveButton', 'cancelButton',
            '|', 'formatting',
            '|', 'bold', 'italic', 'deleted', 'underline',
            '|', 'unorderedlist', 'orderedlist',
            '|', 'table', 'link',
            '|', 'fontcolor', 'backcolor',
            '|', 'html'
          ],
          removeEmptyTags: false
        };
        break;

      default:
        return null;
    }

    return $.extend(default_options, special_options);
  };

  var cms_fields = function(content, field_type) {
    return content.find('[data-ip-field-type="' + field_type + '"]');
  };

  var add_onclick_redactor_handlers = function(content) {
    _.each(['string', 'html'], function(field_type) {
      _.each(cms_fields(content, field_type), function(cms_field) {
        var dom_element = $(cms_field);
        var redactor_options = redactor_options_for_type(field_type);

        if(redactor_options !== null) {
          if(!dom_element.hasClass('ip_field_editable')) {
            dom_element.addClass('ip_field_editable');

            dom_element.on('click', function(e) {
              e.preventDefault();

              if(dom_element.data('redactor') === undefined) {
                dom_element.html(dom_element.infopark('content') || '');
                dom_element.redactor(redactor_options);
              }
            });
          }
        }
      });
    });
  };

  infopark.on('editing', function() {
    add_onclick_redactor_handlers($('body'));
  });

  infopark.on('new_content', function(dom_element) {
    add_onclick_redactor_handlers($(dom_element));
  });
});
