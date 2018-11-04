$(document).ready(function() {
  $('#passwords-title-filter').keyup(function() {
    var query = $(this).val().toLowerCase(); 
    filterPasswords(query, 'title');
  });

  $('#domain-filter').keyup(function() {
    var query = $(this).val().toLowerCase(); 
    filterPasswords(query, 'domain');
  });
});

function filterPasswords(query, type = 'title') {
  if (query.length <= 0) {
    $('div.password').parent().removeClass('hidden');
  }
  else {
    var contentSelector = null;
    if (type === 'title')
      contentSelector = 'h4';
    else if(type === 'domain')
      contentSelector = 'p.domain';

    if (contentSelector === null)
      return;

    $('div.password').each(function(index) {
      var content = $(this).find(contentSelector).html().trim(); 
      console.log(content);
      if(content.toLowerCase().indexOf(query) !== -1) {
        $(this).parent().removeClass('hidden');
      }
      else {
        $(this).parent().addClass('hidden');
      }
    });
  }
}
