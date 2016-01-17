// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function () {
  setTimeout(function () {
    $('.preloader').fadeOut();
  }, 1000);

  function slideImage(el) {
    var nextId = $(el).data('id');
    var $activeLi = $('ul.points li.active');
    var currentId = $activeLi.data('id');
    $activeLi.removeClass('active');
    $(el).addClass('active');
    $('img#'+currentId).animate({marginLeft: '-244px'}, function () {
      $('img#'+currentId).hide();
      $('img#'+nextId).css('margin-left', 0).fadeIn();
    });
  }

  function autoPlay() {
    return setInterval(function () {
      var currentId = parseInt($('ul.points li.active').data('id'));
      currentId++;
      if (currentId > 4) currentId = 1;
      var $nextLi = $('ul.points li[data-id='+currentId+']');
      slideImage($nextLi);
    }, 5000);
  }

  var interval = autoPlay();

  $('ul.points li').click(function (e) {
    e.preventDefault();
    clearInterval(interval);
    slideImage(this);
    interval = autoPlay();
  });


});
