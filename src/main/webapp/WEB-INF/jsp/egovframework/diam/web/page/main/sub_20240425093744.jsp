<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<link rel="stylesheet" href="/js/egovframework/diam/slickslider/slick.css"/>
<style>
	.slide_top_wrap { max-width:1100px; }
	.sld-wrp { width: 100%; margin: 0; overflow:hidden;	}
	.slider_for_wrap { position:relative; width: 580px; margin: 0; float:left; z-index: 10; overflow:hidden; }
	.slider-for { }
	.slide-container { height: 330px; text-align: center; line-height: 330px; box-sizing: border-box; }
	.slide-container a { display: block; width: 100%; height: 100%; overflow: hidden; transition: all .25s; }
	.slide-container .img_con .img { position: relative; width: 100%; padding-top: 56.82%; background-position: center; background-size: cover; background-repeat: no-repeat; overflow: hidden; /* width:404px; height:230px; */ }
	.slide-container .img_con .img img { opacity: 0; visibility: hidden; position: absolute; top: 50%; left: 50%; transform: translate(-50%,-50%); /* width:100%; height:100%; background-color:#C4C4C4; */ }
	
	.slick-disabled { cursor: not-allowed; }
	.slider-nav { display: none; }
	.slider-nav .slick-track { min-width: 100%; transform: translate3d(0, 0, 0)!important; }
	.control-wrap { display:flex; justify-content:flex-end; align-items:center; gap:0 10px; position:absolute; left:0; bottom:0; z-index:20; width:100%; height:30px; padding:0 5px; background:#000; color:#fff; box-sizing:border-box; }
	.control-wrap > div { display:block; width:23px; height:23px; cursor:pointer; }
	.control-wrap .play { background-image:url('../images/main/btn_con_play.png'); }
	.control-wrap .stop { background-image:url('../images/main/btn_con_pause.png'); }
	.control-wrap .numcount { width:auto; height:auto; position:static; font-size:1.188rem; font-weight:500; letter-spacing:-0.02em; }
	.control-wrap .prevArrow { background-image:url('../images/main/btn_con_prev.png'); }
	.control-wrap .nextArrow { background-image:url('../images/main/btn_con_next.png'); }
	
	@media screen and (min-width: 796px) {
		.slider-nav { display: block; float:right; width:480px; height:330px; }
		.slider-nav .slide-btn { display:flex; align-items:center; justify-content:center; box-sizing:border-box; margin-bottom:20px; cursor:pointer; }
		.slider-nav .slide-btn:hover { }
		.slider-nav .slide-btn:last-child { margin-bottom:0; }
		.slider-nav .thumb_img { width:140px; height:95px; }
		.slider-nav .thumb_img img { width:100%; height:100%; border-radius:5px; background-color:#C4C4C4; }
		.slider-nav .thumb_txt { width:calc(100% - 140px); margin-left:12px; }
		.slider-nav .thumb_txt .type { font-size:0.625rem; line-height:1.3; }
		.slider-nav .thumb_txt .t04 { display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; height:35px; margin-top:5px; color:#000; white-space:normal; word-wrap:break-word; text-overflow:ellipsis; overflow:hidden; }
	}
</style>

<div class="slide_top_wrap">
	<div class="sld-wrp">
		<div class="slider_for_wrap">
			<div class="slider-for">
				<div class="slide-container">
					<a href="#">
						<div class="img_con">
							<p class="img" style="width:100%; padding-top:56.82%; background-image: url('/resources/board/webzinetemp/20231222100640_대지 24@2x-100.jpg');"><img src="/resources/board/webzinetemp/20231222100640_대지 24@2x-100.jpg" alt="" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></p>
						</div>
					</a>
				</div>
				<div class="slide-container">
					<a href="#">
						<div class="img_con">
							<p class="img" style="width:100%; padding-top:56.82%; background-image: url('/resources/board/webzinetemp/20231222101545_대지 27@2x-100.jpg');"><img src="/resources/board/webzinetemp/20231222101545_대지 27@2x-100.jpg" alt="" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></p>
						</div>
					</a>
				</div>
				<div class="slide-container">
					<a href="#">
						<div class="img_con">
							<p class="img" style="width:100%; padding-top:56.82%; background-image: url('/resources/board/webzinetemp/20231222100640_대지 24@2x-100.jpg');"><img src="/resources/board/webzinetemp/20231222100640_대지 24@2x-100.jpg" alt="" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></p>
						</div>
					</a>
				</div>
			</div>
			<div class="control-wrap">
				<div class="numcount sPage1"><span class="now">1</span><span> / 3</span></div>
				<div class="prevArrow"><span class="sr-only">이전</span></div>
				<div class="play"><span class="sr-only">재생</span></div>
				<div class="stop"><span class="sr-only">정지</span></div>
				<div class="nextArrow"><span class="sr-only">다음</span></div> 
 			</div>
 		</div>
		<div class="slider-nav">
			<div class="slide-btn">
				<div class="thumb_img"><img src="/resources/board/webzinetemp/20231222100640_대지 24@2x-100.jpg" alt="" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></div>
				<div class="thumb_txt">
					<p class="type type_1">people</p>
					<p class="t04">쓰레기 문제 해결을 위한 순환 실험실, ‘한 걸음 가게’의 김지현  대표를 찾아서</p>
				</div>
			</div>
			<div class="slide-btn">
				<div class="thumb_img"><img src="/resources/board/webzinetemp/20231222101545_대지 27@2x-100.jpg" alt="" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></div>
				<div class="thumb_txt">
					<p class="type type_1">people</p>
					<p class="t04">‘가족애’를 이야기하는 동화 작가, 김숙 주임</p>
				</div>
			</div>
			<div class="slide-btn">
				<div class="thumb_img"><img src="/resources/board/webzinetemp/20231222100640_대지 24@2x-100.jpg" alt="" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></div>
				<div class="thumb_txt">
					<p class="type type_1">people</p>
					<p class="t04">[민원과의 전쟁] 아니! 이게 광주환경공단 업무가 아니라고?</p>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-2.2.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/js/egovframework/diam/slickslider/slick.min.js"/></script>

<script>
	$(document).on('ready', function() {
		$('.slider-for').slick({
			slidesToShow: 1,
			slidesToScroll: 1,
			arrows: true,
			autoplay: true,
			autoplaySpeed : 3000,
			infinite: true,
			infiniteSlide: 0,
			asNavFor: '.slider-nav',
			prevArrow : $('.prevArrow'), 
			nextArrow : $('.nextArrow'),
		});
		$('.slider-nav').slick({
			vertical: true,
			slidesToShow: 3,
			slidesToScroll: 1,
			arrows: false,
			asNavFor: '.slider-for',
			centerMode: false,
			autoplay: false,
			swipe: false,
			focusOnSelect: true
		});
		$('.slider-for').on('init reInit afterChange', function(event, slick, currentSlide, nextSlide){ 
			var i = (currentSlide ? currentSlide : 0) + 1;
			$('.sPage1').html("<span class='now'>"+i+"</span><span> / "+slick.slideCount+"</span>");
		}); 
		// 재생/정지 버튼 컨트롤
		$('.play').click(function(){
			$('.slider-for').slick('slickPlay');
		}); 
		$('.stop').click(function(){
			$('.slider-for').slick('slickPause');
		});
	});
</script>