$(document).ready(function() {
  infopark.on('new_content', function() {
    var elements = $('[data-ip-field-type=enum], [data-ip-field-type=multienum]')

    elements.each(function(index) {
      var element = $(this)

      element.on('focusout', function() {
        var self = $(this)

        self.infopark('save', self.val())
      });
    });
  });
});