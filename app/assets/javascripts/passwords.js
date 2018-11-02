$(document).ready(function() {
  $('#passwords-title-filter').keyup(function() {
    var query = $(this).val().toLowerCase();
    var $table = $(this).closest('table.table');
    filterTable(query, $table, 'td:nth-child(2)');
  });

  $('#url-filter').keyup(function() {
    var query = $(this).val().toLowerCase();
    var $table = $(this).closest('table.table');
    filterTable(query, $table, 'td:nth-child(3)');
  });
});

function filterTable(query, $targetTable, targetSelector) {
  if (query.length <= 0) {
    $targetTable.children('tbody').children('tr').each(function(index) {
      $(this).removeClass('hidden');
    });
  }
  else {
    $targetTable.children('tbody').children('tr').each(function(index) {
      var content = $(this).children(targetSelector).html().trim(); 
      if(content.toLowerCase().indexOf(query) !== -1) {
        $(this).removeClass('hidden');
      }
      else {
        $(this).addClass('hidden');
      }
    });
  }
}
