$(document).ready(function() {
  $('#passwords-title-filter').keyup(function() {
    var query = $(this).val();
    var $table = $(this).closest('table.table');
    if (query.length <= 0) {
      $table.children('tbody').children('tr').each(function(index) {
        $(this).removeClass('hidden');
      });
    }
    else {
      $table.children('tbody').children('tr').each(function(index) {
        var content = $(this).children('td:nth-child(2)').html().trim(); 
        if(content.indexOf(query) !== -1) {
          $(this).removeClass('hidden');
        }
        else {
          $(this).addClass('hidden');
        }
      });
    }
  });
});
