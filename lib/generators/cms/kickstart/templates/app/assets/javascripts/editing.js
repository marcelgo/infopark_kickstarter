$(document).ready(function() {
  infopark.on('editing', function() {
    $('.structure').each(function(){
      $(this).siblings('.ip_editing_marker').each(function(){
        $(this).addClass('structure');
      });
    });

    $(".structure:not(:has(.highlighted)) [class*='span']").hover(
      function() {
        $(this).addClass('highlighted');
      },
      function() {
        $(this).removeClass('highlighted');
      }
    );
  });

  infopark.on('new_content', function() {
    var elements = $('.editing').find('[data-ip-field-type=enum], [data-ip-field-type=multienum]')

    elements.each(function(index) {
      var element = $(this)

      element.on('focusout', function() {
        var self = $(this)

        self.infopark('save', self.val())
      });
    });
  });
});