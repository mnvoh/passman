$(document).on('ready turbolinks:load', function() {
  $('input.field_with_errors').each(function(index) {
    $(this).parent().addClass('field_with_errors');
  });
});
