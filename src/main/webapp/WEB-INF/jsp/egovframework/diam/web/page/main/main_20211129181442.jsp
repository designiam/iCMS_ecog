<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!-- 최신 발행호 중 3개 콘텐츠 슬라이드// -->
<!-- topSlider// -->
<div id="topSlider">
	<div class="swiper-wrapper">
		<div class="swiper-slide"> 
			<a href="#" target="#">
				<img src="/thema/basic/images/main/img_visual_1.png" alt="">
			</a>
		</div>
		<div class="swiper-slide"> 
			<a href="#" target="#">
				<img src="/thema/basic/images/main/img_visual_1.png" alt="">
			</a>
		</div>
		<div class="swiper-slide"> 
			<a href="#" target="#">
				<img src="/thema/basic/images/main/img_visual_1.png" alt="">
			</a>
		</div>
	</div>
	<div class="swiper-button-prev"></div>
	<div class="swiper-button-next"></div>
</div>
<!-- //topSlider -->
<!-- //최신 발행호 중 3개 콘텐츠 슬라이드 -->

<!-- guick_banner// -->
<div id="guick_banner">
	<div class="inner">
		<ul class="quick_list">
			<li><a href="https://www.instagram.com/ecogwangju_official/" target="_blank" title="새창열림" rel="noopener noreferrer"><i class="instagram"></i><span class="hidden">인스타그램</span></a></li>
			<li><a href="https://blog.naver.com/ecogj" target="_blank" title="새창열림" rel="noopener noreferrer"><i class="blog"></i><span class="hidden">네이버블로그</span></a></li>
			<li><a href="https://www.facebook.com/ecogwangju" target="_blank" title="새창열림" rel="noopener noreferrer"><i class="facebook"></i><span class="hidden">페이스북</span></a></li>
			<li><a href="https://www.youtube.com/channel/UCCd9MhX9BrrS-vIbevOvo7w" target="_blank" title="새창열림" rel="noopener noreferrer"><i class="youtube"></i><span class="hidden">유튜브</span></a></li>
			<li><a href="https://pf.kakao.com/_lxegxnxb" target="_blank" title="새창열림" rel="noopener noreferrer"><i class="kakao"></i><span class="hidden">카카오채널</span></a></li>
			<li><a href="?contentId=8180651d8a732fbb4725b901344c433690e13340dae9f2585414d363ee17aaf0"><i class="opinion"></i><span>의견게시판</span></a></li>
		</ul>
	</div>
</div>
<!-- //guick_banner -->

<!-- 추천콘텐츠, 월간베스트, 최신콘텐츠// -->
<div id="top_con_slide">
	<!-- .inner// -->
	<div class="inner">
		<div class="tabMenu-wrap tab-style-03">
			<ul>
				<li class="tabMenu" data-value="1" data-id="">추천 콘텐츠</li>
				<li class="tabMenu" data-value="2" data-id="">월간 BEST</li>
				<li class="tabMenu" data-value="3" data-id="">최신 콘텐츠</li>
			</ul>
		</div>
		<!-- //.tabMenu-wrap -->
	
		<div class="tabContent-wrap">
			<div class="tabContent" data-aos="fade-up">
			
			
			
				<div class="top_con_box top_con_swiper swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="img_con">
								<p class="img"><img src="/thema/basic/images/main/img_test.jpg" alt="" /></p>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="img_con">
								<p class="img"><img src="/thema/basic/images/main/img_test1111.jpg" alt="" /></p>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="img_con">
								<p class="img"><img src="/thema/basic/images/main/img_test.jpg" alt="" /></p>
							</div>
						</div>
					</div>
					<div class="control-wrap">
						<div class="swiper-pagination"></div>
						<div class="swiper-gallery-prev"><span class="hidden">이전</span></div>
						<div class="swiper-gallery-play"><span class="hidden">시작</span></div>
						<div class="swiper-gallery-pause"><span class="hidden">정지</span></div>
						<div class="swiper-gallery-next"><span class="hidden">다음</span></div>
					</div>
				</div>
				<div class="gallery-thumb-box gallery-thumb-swiper swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide">
							<div class="thumb_img"><img src="/thema/basic/images/main/img_test2.jpg" alt="" /></div>
							<div class="thumb_txt">
								<p class="cate type_1">Article</p>
								<p class="t04">장애인 직업 재활지원과 자원순환을 위한 폐토너 카트리지 기부 장애인 직업 재활지원과 자원순환을 위한 폐토너 카트리지 기부</p>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="thumb_img"><img src="/thema/basic/images/main/img_test2.jpg" alt="" /></div>
							<div class="thumb_txt">
								<p class="cate type_2">People</p>
								<p class="t04">장애인 직업 재활지원과 자원순환을 위한 폐토너 카트리지 기부 장애인 직업 재활지원과 자원순환을 위한 폐토너 카트리지 기부</p>
							</div>
						</div>
						<div class="swiper-slide">
							<div class="thumb_img"><img src="/thema/basic/images/main/img_test2.jpg" alt="" /></div>
							<div class="thumb_txt">
								<p class="cate type_3">함께G</p>
								<p class="t04">장애인 직업 재활지원과 자원순환을 위한 폐토너 카트리지 기부 장애인 직업 재활지원과 자원순환을 위한 폐토너 카트리지 기부</p>
							</div>
						</div>
					</div>
				</div>
				<script>
					$(function(e) {					
						var thumbSwiper = new Swiper('.gallery-thumb-swiper', {
							spaceBetween: 0,
							slidesPerView: 1,
							speed: 3000,
							freeMode: true,
							watchSlidesVisibility: true,
							watchSlidesProgress: true,
							observer: true,
							observeParents: true,
							breakpoints: {
								1024: {
									slidesPerView: 3
								},
								768: {
									slidesPerView: 3
								},
								486: {
									slidesPerView: 3
								}
							}
						});
						var mainSwiper = new Swiper('.top_con_swiper', {
							effect: 'fade',
							spaceBetween: 0,
							loop: true,
							slidesPerView : 1,
							slidesPerGroup : 1,
							navigation: {
								nextEl: '.swiper-gallery-next',
								prevEl: '.swiper-gallery-prev',
							},
							pagination: {
							  el: ".swiper-pagination",
							  type: "fraction",
							},
						    autoplay : {
						        delay : 3000, // 슬라이드 이동 시간 간격
						        disableOnInteraction : false, // 버튼을 이용하여 컨트롤 한 이후에도 자동 재생 유지되도록
						    },
							thumbs: {
								swiper: thumbSwiper
							}
						});
					});
					// 자동 재생 시작, 정지 버튼 만들기 스크립트
					$('.top_con_swiper .swiper-gallery-pause').on('click', function() {
					    swiper.autoplay.stop();
					})
					$('.top_con_swiper .swiper-gallery-play').on('click', function() {
					    swiper.autoplay.start();
					})
				</script>
				
			</div>
		</div>
		<!-- //.tabContent-wrap -->
	</div>
	<!-- //.inner -->
</div>
<!-- //추천콘텐츠, 월간베스트, 최신콘텐츠 -->

















<section class="main-section sec-best" style="display:none;">
	<div class="side-content">
		<div class="title">
			<h2>월간 <p><b>BEST</b></p></h2>
		</div>
		<div class="txt">
			<p>
				광주환경공단이 <br>
				엄선한 콘텐츠들을 한눈에 볼 수 있습니다.
			</p>
		</div>
	</div>
	<!-- //.side-content -->
		
	<div class="inner_con">
		<div class="" id="bestSlider" data-aos="fade-up">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<a href="#;">
						<div class="img"></div>
						<div class="txt">
							<p class="subject"></p>
							<p class="content"></p>
							<p class="date"></p>
						</div>
					</a>
				</div>
			</div>
		</div>
		<!-- //#bestSlider -->
	</div>
	<!-- //.inner_con -->
</section>
<!-- //.main-section.sec-best -->


<section class="main-banner" style="display:none;">
	<c:choose>
		<c:when test="${fn:length(bannerList) > 0}">
			<div class="banner-slide " id="banSlider">
				<ul class="pc-banner">
				<c:forEach var="result" items ="${bannerList}" varStatus="index">
					<c:choose>
						<c:when test="${result.dm_link ne null && not empty result.dm_link}">
							<c:if test="${result.dm_status eq 1 }">
							<li class="" style="background-image: url('/resources/banner/${result.dm_banner_img}');">
								<a href="${result.dm_link}" target="${result.dm_link_type}">
									<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
								</a>
							</li>
							</c:if>
						</c:when>
						<c:otherwise>
							<c:if test="${result.dm_status eq 1 }">
							<li class="" style="background-image: url('/resources/banner/${result.dm_banner_img}');">
								<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
							</li>
							</c:if>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</ul>
			</div>
			<div class="banner-slide " id="m-banSlider">
				<ul class="m-banner">
					<c:forEach var="result" items ="${bannerList}" varStatus="index">
						<c:choose>
							<c:when test="${result.dm_link ne null && not empty result.dm_link}">
							<li class="" style="background-image: url('/resources/banner/${result.dm_mbanner_img}');">
								<a href="${result.dm_link}" target="${result.dm_link_type}">
									<img src="/resources/banner/${result.dm_mbanner_img}" alt="${result.dm_banner_nm}">
								</a>
							</li>
							</c:when>
							<c:otherwise>
								<li class="" style="background-image: url('/resources/banner/${result.dm_mbanner_img}');">
									<img src="/resources/banner/${result.dm_mbanner_img}" alt="${result.dm_banner_nm}">
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</ul>
			</div>
		</c:when>
	</c:choose>
</section>
<!-- //.main-banner -->


<section class="main-section sec-now" style="display:none;">
	<div class="side-content">
		<div class="title">
			<h2>ECO-G <p><b>NOW</b></p></h2>
		</div>
		<div class="txt">
			<p>
				광주환경공단 <br>
				주요소식을 전합니다.
			</p>
		</div>
		
		<div class="tabMenu-wrap tab-style-03">
			<ul>
				<li class="tabMenu" data-value="1" data-id="271">Contents</li>
				<li class="tabMenu" data-value="2" data-id="272">Article</li>
				<li class="tabMenu" data-value="3" data-id="273">Life</li>
			</ul>
		</div>
		<!-- //.tabMenu-wrap -->
	</div>
	<!-- //.side-content -->
		
	<div class="inner_con">
		<div class="tabContent-wrap">
			<div class="tabContent" data-aos="fade-up">
				<div class="masonry" >
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample01.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 하천 화장실 '안심'하고 이용하세요.</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
				</div>
				<!-- //.masonry -->
			</div>
		</div>
		<!-- //.tabContent-wrap -->
	</div>
	<!-- //.inner_con -->
</section>
<!-- //.main-section.sec-now -->

<section class="main-section sec-sns" style="display:none;">
	<div class="side-content">
		<div class="title">
			<h2>소통해요 <p><b>#SNS</b></p></h2>
		</div>
		<div class="txt">
			<p>
				광주환경공단이 <br>
				엄선한 콘텐츠들을 한눈에 볼 수 있습니다.
			</p>
		</div>
		<div class="sns-wrap">
			<ul>
				<li class="sns-blog"><a href="https://blog.naver.com/ecogj" target="_blank"><span class="sr-only">네이버 블로그</span></a></li>
				<li class="sns-youtube"><a href="https://www.youtube.com/channel/UCCd9MhX9BrrS-vIbevOvo7w" target="_blank"><span class="sr-only">유튜브</span></a></li>
				<li class="sns-instagram"><a href="https://www.instagram.com/ecogwangju_official/" target="_blank"><span class="sr-only">인스타그램</span></a></li>
				<li class="sns-facebook"><a href="https://www.facebook.com/ecogwangju" target="_blank"><span class="sr-only">페이스북</span></a></li>
				<li class="sns-kakao"><a href="https://pf.kakao.com/_lxegxnxb" target="_blank"><span class="sr-only">카카오톡 채널</span></a></li>
			</ul>
		</div>
		<!-- //.sns-wrap -->
	</div>
	<!-- //.side-content -->
	<div class="inner_con">
		<div>
			<div class="video-container">
				<div class="video-wrap" id="setYoutube">
					<iframe title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
				</div>
			</div>
			<div class="txt">
				<div class="subject">광주환경공단 유튜브영상</div>
				<div class="content"></div>
			</div>
		</div>
		
		<div class="insta-txt">INSTAGRAM</div>
		
		<div class="swiper-container" id="snsSlider" data-aos="fade-up">
			<div class="swiper-wrapper">
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
				<div class="swiper-slide"><a target="_blank" href=""><img src="" alt="인스타그램 게시물"></a></div>
			</div>
			<div class="swiper-controller">
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
			</div>
			<!-- //.swiper-controller -->
		</div>
		<!-- //#snsSlider -->
	</div>
	<!-- //.inner_con -->
</section>

<script>
	$(function() {
		//최신 발행호
		var topSlider = new Swiper( '#topSlider', {
			slidesPerView: 'auto',
			speed: 3000,
			allowTouchMove:true,
			loop: true,
			autoplay: {
			delay: 3000,
			autoplayDisableOnInteraction: false,
			disableOnInteraction: false,
			pauseOnMouseEnter:true,
			},
			
			navigation: {
				nextEl: '#topSlider .swiper-button-next',
				prevEl: '#topSlider .swiper-button-prev',
			},
		});
	});
</script>

<script>
$(function(){
	getPopularData();
	getMenuContents(getMenuId());
	getCrawlData();
});

var getCrawlData = function(){
	$.ajax({
		url : "/web/selectCrawlData.do",
		type: "get"
	}).done(function(response){
		setYoutube(response.youtube);
		setInstagram(response.insta);
	}).fail(function(response, status, error){
		alert(response.responseJSON.notice);
	}).then(function(){
		//SNS 슬라이드
		var snsSlider = new Swiper("#snsSlider", {
			slidesPerView: 'auto',
			spaceBetween: 10,
			centeredSlides: true,
			slideToClickedSlide : true,
			autoplay: {
				delay: 3500,
				disableOnInteraction: false,
			},
			loop : true,
			loopAdditionalSlides : 1,
			observer: true,
			observeParents: true,
			navigation: {
				nextEl: "#snsSlider .swiper-button-next",
				prevEl: "#snsSlider .swiper-button-prev",
			},
			breakpoints: {
				768: {
					spaceBetween: 25,
				},
			},
		});
	});
}
function setInstagram(rows) {
	var target = $("#snsSlider").find(".swiper-wrapper");
	if (rows.length > 0) {
		target.empty();
		var str = "";
		$.each(rows, function(i,obj){
			str += '<div class="swiper-slide"><a target="_blank" href="'+obj.dm_href+'"><img src="'+obj.dm_src+'" alt="인스타그램 게시물"></a></div>';
		});
		target.append(str);
	}
}


function setYoutube(data) {
	if (data.dm_href != "" && data.dm_href != null) {
		var uniq = data.dm_href.split("?v=")[1];
		$("#setYoutube").children("iframe").attr("src","https://www.youtube-nocookie.com/embed/"+uniq+"?controls=0");
	}
}

//월간 BEST
function getPopularData() {
	var set = {
		url: "/web/selectPopularWrite.do",
		data: {wr_vol : "${sessionScope.vol}"},
		type: "get"
	}
	
	asyncFunc(set)
	.done(function(data){
		
		if (data.rows.length > 0) {
			var str = '<ul class="">';
			
			$.each(data.rows, function(i, obj){
				str +='<li class=" ">';
				str +='<a href="?contentId='+obj.uid+'&wr_id='+obj.wr_id+'&command=view">';
				str +='<div class="img">';
				str +='<img src="'+obj.wr_path+obj.wr_thumb_sub+'" alt="" onerror="this.src=\'/images/no_image.png\'">';
				str +='</div>';
				str +='<div class="txt">';
				str +='<p class="subject">'+obj.wr_subject+'</p>';
				str +='<p class="content">'+obj.wr_summary+'</p>';
				str +='<p class="date">'+obj.wr_datetime.substring(0,10)+'</p>';
				str +='</div>';
				str +='</a>';
				str +='</li>';
			});
			str += '</ul>';
			var target = $("#bestSlider");
			target.empty();
			target.append(str);
		}
	}).fail(function(request, status, error){
		alert(request.responseJSON.notice);
	});
}

//ajax 함수
function asyncFunc(set) {
	return $.ajax(set);
}

//탭 레이아웃 리스너
$(".tabMenu").on("click",function(){
	if ($(this).attr("class").indexOf("on") > -1) {
		$(this).removeClass("on").attr("title", "");
	} else {
		$(".on").removeClass("on").attr("title", "");
		$(this).addClass("on").attr("title", "선택됨");
	}
	
	var menuArr = new Array();
	var menuId = $(".on").data("id");

	if (menuId == "" || menuId == null) {
		getMenuContents(getMenuId());
	} else {
		menuArr.push(menuId);
		getMenuContents(menuArr);
	}
});
//1차 메뉴 아이디 get 함수
function getMenuId(){
	
	var menuArr = new Array();
	var tabs = $(".tabMenu");
	$.each(tabs, function(i, obj){
		menuArr.push($(obj).data("id"));
	});
	
	return menuArr;
}
//메뉴 아이디로 게시글 get 함수
function getMenuContents(arr) {
	
	if (arr.length < 1) {
		alert("잘못된 접근입니다. 새로고침 후 이용해주세요.");
		location.reload();
		return;
	}
	
	var set = {
       	url: "/web/selectChildMenuBoard.do",
       	type: "get",
       	data: {
       			dm_id : arr,
       			page : 1
       		}
       }
    
  	asyncFunc(set)
	.done(function(data){
		if (data.result == "success") {
			setNowList(data.rows);
		} else {
			var target = $(".masonry");
			var str = '<div><img src="'+'<c:out value="${layout_path}" />'+'/images/noimg_main.jpg" /></div>';
			target.empty();
			target.append(str);
		}
	}).fail(function(request, status, error){
		alert(request.responseJSON.notice);
   	});
}
// eco-g now 리스트 세팅
function setNowList(rows){
	var target = $(".masonry");
	var str = "";
	$.each(rows, function(i, obj){
		var cate = "";
		switch (obj.type) {
			case "271":
				cate = "Contents";
				break;
			case "272":
				cate = "Article";
				break;
			default:
				cate = "Life";
				break;
		}
		str += '<div class="masonry-item">';
		str += '<a href="?contentId='+obj.uid+'&wr_id='+obj.wr_id+'&command=view">';
		str += '<div class="img"><img src="'+obj.wr_path+obj.wr_thumb+'" alt="" onerror="this.src=\'/images/no_image.png\'"></div>';
		str += '<div class="txt">';
		str += '<p class="subject">'+obj.wr_subject+'</p>';
		str += '<p class="cate">'+cate+'</p>';
		str += '</div>';
		str += '</a>';
		str += '</div>';
	});
	target.empty();
	target.append(str);
}

//인기 게시글 슬라이드
//var bestSlider = new Swiper("#bestSlider", {
//	slidesPerView: 2,
//	spaceBetween: 20,
//	autoplay: {
//		delay: 3500,
//		disableOnInteraction: false,
//	},
//	loop : false,
//	loopAdditionalSlides : 1,
//	breakpoints: {
//		768: {
//			slidesPerView: 3,
//			spaceBetween: 20,
//		},
//		1600: {
//			slidesPerView: 3,
//			spaceBetween: 40,
//		},
//		2200: {
//			slidesPerView: 4,
//			spaceBetween: 60,
//		},
//	},
//});
AOS.init();
</script>