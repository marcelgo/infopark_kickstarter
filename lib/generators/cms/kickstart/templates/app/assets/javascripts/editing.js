var Editing = {
  // Support enum and multienum fields to save their data back to the CMS using
  // the Infopark JavaScript API.
  enumSupport: function() {
    var elements = $('[data-ip-field-type=enum], [data-ip-field-type=multienum]');

    elements.each(function(index) {
      var element = $(this);

      element.on('focusout', function() {
        var self = $(this);

        self.infopark('save', self.val());
      });
    });
  }
};

$(document).ready(function() {
  infopark.on('new_content', function() {
    Editing.enumSupport();
  });
});
