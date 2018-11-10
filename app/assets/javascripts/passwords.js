$(document).ready(function() {
  $('#passwords-title-filter').keyup(function() {
    var query = $(this).val().toLowerCase(); 
    filterPasswords(query, 'title');
  });

  $('#domain-filter').keyup(function() {
    var query = $(this).val().toLowerCase(); 
    filterPasswords(query, 'domain');
  });

  $('.copy-text').click(function() {
    var elementId = $(this).data('for');
    var element = $('#' + elementId);
    element.select();
    document.execCommand('copy');
    $('.copied-to-clipboard').fadeIn(300);
    setTimeout(function() {
      $('.copied-to-clipboard').fadeOut(1000);
    }, 3000);
  });

  $('input[type=range]').on('change input', function() {
    var target = $(this).data('target');
    $('.' + target).html($(this).val());
  });

  $('#generate-password-form').submit(function() {
    var lower = $(this).find('input[name=lower]').prop('checked');
    var upper = $(this).find('input[name=upper]').prop('checked');
    var numbers = $(this).find('input[name=numbers]').prop('checked');
    var symbols = $(this).find('input[name=symbols]').prop('checked');
    var length = $(this).find('input[name=length]').val();

    var url = $(this).prop('action');
    var data = {
      lower: lower,
      upper: upper,
      numbers: numbers,
      symbols: symbols,
      length: length,
    };

    var _this = this;
    $.get(url, data, function(data) {
      $('#generated-password').val(data.random);
    });

    return false;
  });

  $('.password-indicator-enabled').on('keyup change', function() {
    var indicatorId = $(this).data('indicator');
    var indicatorMessageId = $(this).data('indicator-message');

    var score = -1;
    var warning = '';

    if ($(this).val().length > 0) {
      var testResult = zxcvbn($(this).val());
      warning = testResult.feedback.warning;
      score = testResult.score;
    }

    $(indicatorMessageId).html(warning);
    $(indicatorId).find('i').each(function(index) {
      if (index <= score) {
        $(this).removeClass('hollow');
        $(this).addClass('filled');
      }
      else {
        $(this).removeClass('filled');
        $(this).addClass('hollow');
      }
    });
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
