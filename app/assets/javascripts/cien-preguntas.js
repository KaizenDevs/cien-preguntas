$(document).on('ready page:load', function () {
  function checkitem(carousel_identifier){

    total = $('.item').size();
    current = $(carousel_identifier + ' .active').index('.carousel .item') + 1;

    if (current === total){ $('.right.carousel-control').hide();}
    else {$('.right.carousel-control').show();}

    if (current === 1){ $('.left.carousel-control').hide();}
    else {$('.left.carousel-control').show();}
    }
  checkitem('.carousel');
  $(".carousel").on('slid.bs.carousel', function() {  checkitem('.carousel') });
});


