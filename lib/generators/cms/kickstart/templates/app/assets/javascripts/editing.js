infopark.on('editing', function() {
  // Identify all structure widgets and mark their matching edit marker as well,
  // so they can be styled differently.
  $('.structure').each(function() {
    var editMarker = $(this).siblings('.ip_editing_marker');

    editMarker.each(function() {
      $(this).addClass('structure');
    });
  });

  // Hovering over a structure widget highlights the entire widget to make sure
  // the editor can see the area that can be edited.
  $("widget.structure").hover(function() {
    $(this).stop(true, true).toggleClass('highlighted');
  });
});

infopark.on('new_content', function() {
  var elements = $('.editing').find('[data-ip-field-type=enum], [data-ip-field-type=multienum]');

  elements.each(function(index) {
    var element = $(this);

    element.on('focusout', function() {
      var self = $(this);

      self.infopark('save', self.val());
    });
  });
});