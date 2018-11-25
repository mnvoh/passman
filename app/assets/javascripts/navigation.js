$(document).ready(function () {
  $('.navbar-toggler').on('click', function () {
    $('.animated-icon1').toggleClass('open');
    $('.animated-icon3').toggleClass('open');
    $('.animated-icon4').toggleClass('open');
    toggleNav();
  });

  $('#password-generator-link').click(function() {
    $('.navbar-toggler').click();
  });
});

function toggleNav() {
  var isOpen = $('#header-navigation').css('display') != 'none';  
  isOpen ? hideNav() : showNav();
}

function showNav() {
  var $nav = $('#header-navigation');
  $nav.css('top', $('#main-navigation').outerHeight() + 'px');
  $nav.fadeIn(250, function() {
    var containerWidth = $nav.outerWidth();
    var containerHeight = $nav.outerHeight();
    var itemWidth = $('#header-navigation .nav-item').outerWidth();
    var itemHeight = $('#header-navigation .nav-item').outerHeight();
    var maxItemsX = parseInt(containerWidth / itemWidth);
    var maxItemsY = parseInt(containerHeight / itemHeight);
    var ratioX = maxItemsX / (maxItemsX + maxItemsY);
    var ratioY = maxItemsY / (maxItemsX + maxItemsY);
    var menuItemsCount = $('#header-navigation .nav-item').length;
    var itemsX = Math.floor(menuItemsCount * ratioX);
    var itemsY = Math.floor(menuItemsCount * ratioY);
    var items = $('#header-navigation .nav-item');
    var startPosX = containerWidth / 2 - itemsX * itemWidth / 2;
    var startPosY = containerHeight / 2 - itemsY * itemHeight / 2;

    for (var j = 0; j < itemsY; j++) {
      for (var i = 0; i < itemsX; i++) {
        var index = j * itemsX + i
        if (items.length <= index) {
          break;
        }

        $(items[index]).animate({
          right: containerWidth - (startPosX + i * itemWidth) - itemWidth,
          top: startPosY + j * itemHeight + j * 30
        }, 100 + 300 * Math.random());
      }
    }
  });
}

function hideNav() {
  var items = $('#header-navigation .nav-item');
  items.each(function(index, item) {
    $(item).animate({
      top: '-300px',
      right: '-300px'
    }, 100 + 250 * Math.random(), function() {
      if (index >= items.length - 1) {
        $('#header-navigation').fadeOut(250);
      }
    });
  });
}
