
    var totalItems = $('.carousel-item').length;
    var currentIndex = $('.carousel-item.active').index() + 1;
    $('.num').html('' + currentIndex + '/' + totalItems + '');
    $('#carouselExample').on('slide.bs.carousel', function () {
        currentIndex = $('.carousel-item.active').index() + 1;
        $('.num').html('' + currentIndex + '/' + totalItems + '');
    });

   

