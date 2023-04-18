//배너 슬라이드
$(function() {
var sliderAnimation = new SwiperAnimation();
var mainSlider = new Swiper('#banSlider', {
	slidesPerView: 1,
    centeredSlides: true,
    setWrapperSize: true,
    loop: false,
    loopAdditionalSlides : 1,
    observer: true,
    observeParents: true,
    watchOverflow: true,  //슬라이드 한 개 일 때, 버튼 사라짐
    autoplay: {
        delay: 4000,
        disableOnInteraction: false,
    },
    on: {
        init: function () {
            //sliderAnimation.init(this).animate();
        },
        slideChange: function () {
            //sliderAnimation.init(this).animate();
        }
    }
});

var mainSlider = new Swiper('#m-banSlider', {
	slidesPerView: 1,
    centeredSlides: true,
    setWrapperSize: true,
    loop: false,
    loopAdditionalSlides : 1,
    observer: true,
    observeParents: true,
    watchOverflow: true,  //슬라이드 한 개 일 때, 버튼 사라짐
    autoplay: {
        delay: 4000,
        disableOnInteraction: false,
    },
    on: {
        init: function () {
            //sliderAnimation.init(this).animate();
        },
        slideChange: function () {
            //sliderAnimation.init(this).animate();
        }
    }
});

});