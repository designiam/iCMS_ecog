<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="main-section sec-best">
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
		
	<div class="inner">
		<div class="swiper-container" id="bestSlider">
			<div class="swiper-wrapper">
				<div class="swiper-slide">
					<a href="#;">
						<div class="img">
							<img src="${layout_path}/images/main/thumb_best01.jpg" alt="">
						</div>
						<div class="txt">
							<p class="subject">광주환경공단, 하천 화장실 '안심'하고 이용 하세요! 광주환경공단, 하천 화장실 '안심'하고 이용 하세요! 광주환경공단, 하천 화장실 '안심'하고 이용 하세요!</p>
							<p class="content">광주환경공단(이사장 김성환)이 오늘(15일)부터 오는 17일까지 3일간 광주천 등에 설치된 국가하천 공중화장실 21개소에 대해 자체 점검반을 구성, 비상벨 광주환경공단(이사장 김성환)이 오늘(15일)부터 오는 17일까지 3일간 광주천 등에 설치된 국가하천 공중화장실 21개소에 대해 자체 점검반을 구성, 비상벨</p>
							<p class="date">2023-03-14</p>
						</div>
					</a>
				</div>
				<div class="swiper-slide">
					<a href="#;">
						<div class="img">
							<img src="${layout_path}/images/main/thumb_best02.jpg" alt="">
						</div>
						<div class="txt">
							<p class="subject">국가기록원 「기록사랑 공모전」홍보</p>
							<p class="content">행정안전부 국가기록원은 '2030 부산엑스포 유치 기원'의 마음을 담아부산광역시와 공동으로 전 국민 대상 글짓기, 그림그리기, 동영상 제작 기록사랑 공모전」을 개최합니다.</p>
							<p class="date">2023-03-14</p>
						</div>
					</a>
				</div>
				<div class="swiper-slide">
					<a href="#;">
						<div class="img">
							<img src="${layout_path}/images/main/thumb_best03.jpg" alt="">
						</div>
						<div class="txt">
							<p class="subject">광주환경공단, '어린이 SNS 기자단' 모집</p>
							<p class="content">광주환경공단(이사장 김성환)이 오늘(15일)부터 오는 17일까지 3일간 광주천 등에 설치된 국가하천 공중화장실 21개소에 대해 자체 점검반을 구성, 비상벨 </p>
							<p class="date">2023-03-14</p>
						</div>
					</a>
				</div>
				<div class="swiper-slide">
					<a href="#;">
						<div class="img">
							<img src="${layout_path}/images/main/thumb_best01.jpg" alt="">
						</div>
						<div class="txt">
							<p class="subject">광주환경공단, 하천 화장실 '안심'하고 이용 하세요! 광주환경공단, 하천 화장실 '안심'하고 이용 하세요! 광주환경공단, 하천 화장실 '안심'하고 이용 하세요!</p>
							<p class="content">광주환경공단(이사장 김성환)이 오늘(15일)부터 오는 17일까지 3일간 광주천 등에 설치된 국가하천 공중화장실 21개소에 대해 자체 점검반을 구성, 비상벨 광주환경공단(이사장 김성환)이 오늘(15일)부터 오는 17일까지 3일간 광주천 등에 설치된 국가하천 공중화장실 21개소에 대해 자체 점검반을 구성, 비상벨</p>
							<p class="date">2023-03-14</p>
						</div>
					</a>
				</div>
			</div>
		</div>
		<!-- //#bestSlider -->
	</div>
	<!-- //.inner -->
</section>
<!-- //.main-section.sec-best -->


<section class="main-banner">
	<c:choose>
		<c:when test="${fn:length(bannerList) > 0}">
			<div class="banner-slide swiper-container" id="banSlider">
				<ul class="swiper-wrapper pc-banner">
				<c:forEach var="result" items ="${bannerList}" varStatus="index">
					<c:choose>
						<c:when test="${result.dm_link ne null && not empty result.dm_link}">
							<li class="swiper-slide" style="background-image: url('/resources/banner/${result.dm_banner_img}');">
								<a href="${result.dm_link}" target="${result.dm_link_type}">
									<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
								</a>
							</li>
						</c:when>
						<c:otherwise>
							<li class="swiper-slide" style="background-image: url('/resources/banner/${result.dm_banner_img}');">
								<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
								<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				</ul>
			</div>
			<div class="banner-slide swiper-container" id="m-banSlider">
				<ul class="swiper-wrapper m-banner">
					<li class="swiper-slide" style="background-image: url('${layout_path}/images/main/main_ban01_m.png');">
						<a href="${result.dm_link}" target="${result.dm_link_type}">
							<img src="/resources/banner/${result.dm_banner_img}" alt="${result.dm_banner_nm}">
						</a>
					</li>
				</ul>
			</div>
		</c:when>
		<c:otherwise>
			<div class="no-img" style="background-image: url('/images/no_image.png');">
				<img src="/images/no_image.png" alt="등록된 배너가 없습니다."/>
			</div>
		</c:otherwise>
	</c:choose>
</section>
<!-- //.main-banner -->


<section class="main-section sec-now">
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
				<li class="tabMenu on" data-value="1" data-id="271">Contents</li>
				<li class="tabMenu" data-value="2" data-id="272">Article</li>
				<li class="tabMenu" data-value="3" data-id="273">Life</li>
			</ul>
		</div>
		<!-- //.tabMenu-wrap -->
	</div>
	<!-- //.side-content -->
		
	<div class="inner">
		<div class="tabContent-wrap">
			<div class="tabContent" data-target="1">
				<div class="masonry">
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample01.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 하천 화장실 '안심'하고 이용하세요.</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample02.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 단체헌혈로 소중한 생명 나눠요!</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#">
							<div class="img"><img src="${layout_path}/images/main/sample04.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">지역아동센터광주지원단 맞손, 아동복지 증진 공동 모색</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample05.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">재난상황 조직체계 및 프로세스</p>
								<p class="cate">Article</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample06.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">재난상황 조직체계 및 프로세스</p>
								<p class="cate">Article</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample07.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, '어린이 SNS 기자단' 모집</p>
								<p class="cate">Life</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample03.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 장애인 등을 위한 각종 시책 활발</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample08.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">노후설비 대폭 교체로 하수처리 효율 개선한다!</p>
								<p class="cate">Life</p>
							</div>
						</a>
					</div>
				</div>
				<!-- //.masonry -->
			</div>
			<!-- //.tabContent -->
			<div class="tabContent" data-target="2">
				<div class="masonry">
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample02.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 단체헌혈로 소중한 생명 나눠요!</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample01.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 하천 화장실 '안심'하고 이용하세요.</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#">
							<div class="img"><img src="${layout_path}/images/main/sample04.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">지역아동센터광주지원단 맞손, 아동복지 증진 공동 모색</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample05.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">재난상황 조직체계 및 프로세스</p>
								<p class="cate">Article</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample06.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">재난상황 조직체계 및 프로세스</p>
								<p class="cate">Article</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample07.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, '어린이 SNS 기자단' 모집</p>
								<p class="cate">Life</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample03.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 장애인 등을 위한 각종 시책 활발</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample08.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">노후설비 대폭 교체로 하수처리 효율 개선한다!</p>
								<p class="cate">Life</p>
							</div>
						</a>
					</div>
				</div>
				<!-- //.masonry -->
			</div>
			<!-- //.tabContent -->
			<div class="tabContent" data-target="3">
				<div class="masonry">
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample05.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">재난상황 조직체계 및 프로세스</p>
								<p class="cate">Article</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample01.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 하천 화장실 '안심'하고 이용하세요.</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample02.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 단체헌혈로 소중한 생명 나눠요!</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#">
							<div class="img"><img src="${layout_path}/images/main/sample04.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">지역아동센터광주지원단 맞손, 아동복지 증진 공동 모색</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample06.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">재난상황 조직체계 및 프로세스</p>
								<p class="cate">Article</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample07.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, '어린이 SNS 기자단' 모집</p>
								<p class="cate">Life</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample03.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">광주환경공단, 장애인 등을 위한 각종 시책 활발</p>
								<p class="cate">Contents</p>
							</div>
						</a>
					</div>
					<div class="masonry-item">
						<a href="#;">
							<div class="img"><img src="${layout_path}/images/main/sample08.jpg" alt=""></div>
							<div class="txt">
								<p class="subject">노후설비 대폭 교체로 하수처리 효율 개선한다!</p>
								<p class="cate">Life</p>
							</div>
						</a>
					</div>
				</div>
				<!-- //.masonry -->
			</div>
			<!-- //.tabContent -->
		</div>
		<!-- //.tabContent-wrap -->
	</div>
	<!-- //.inner -->
</section>
<!-- //.main-section.sec-now -->

<section class="main-section sec-sns">
	<div class="side-content">
		<div class="title">
			<div>소통해요 <p><b>#SNS</b></p></div>
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
	<div class="inner">
		<div>
			<div class="video-container">
				<div class="video-wrap">
					<iframe src="https://www.youtube-nocookie.com/embed/r_UU_ssSoMg?controls=0" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
				</div>
			</div>
			<div class="txt">
				<div class="subject">광주환경공단 홍보영상</div>
				<div class="content">보이지 않는 곳에서 일하는 사람들이 있습니다. <br> 광주의 환경을 지키는 아름다운 사람들의 이야기, 우리는 광주환경공단입니다.</div>
			</div>
		</div>
		
		<div class="swiper-container" id="snsSlider">
			<div class="swiper-wrapper">
				<div class="swiper-slide"><img src="${layout_path}/images/main/slideSample01.jpg" alt=""></div>
				<div class="swiper-slide"><img src="${layout_path}/images/main/slideSample02.jpg" alt=""></div>
				<div class="swiper-slide"><img src="${layout_path}/images/main/slideSample03.jpg" alt=""></div>
				<div class="swiper-slide"><img src="${layout_path}/images/main/slideSample04.jpg" alt=""></div>
				<div class="swiper-slide"><img src="${layout_path}/images/main/slideSample05.jpg" alt=""></div>
				<div class="swiper-slide"><img src="${layout_path}/images/main/slideSample06.jpg" alt=""></div>
			</div>
			<div class="swiper-controller">
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
			</div>
			<!-- //.swiper-controller -->
		</div>
		<!-- //#snsSlider -->
	</div>
	<!-- //.inner -->
</section>
<script>
$(function(){
	getPopularData();
	$("[data-value=1]").trigger("click");
	
});

//인기순 조회
function getPopularData() {
	var set = {
		url: "/web/selectPopularWrite.do",
		data: {wr_vol : "${sessionScope.vol}"},
		type: "get"
	}
	
	asyncFunc(set)
	.done(function(data){
		console.log(data);
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
    $(".on").removeClass("on").attr("title", " ");
    $(this).addClass("on").attr("title", "선택됨");

    var value = $(this).data("value");
    $("[data-target="+value+"]").show().attr("title", "선택됨");
    $(".tabContent[data-target!="+value+"]").hide().attr("title", " ");
    
    var menuId = $(this).data("id");
    var set = {
    	url: "/web/selectChildMenuBoard.do",
    	type: "get",
    	data: {dm_id : menuId}
    }
    
    asyncFunc(set)
    .done(function(data){
    	if (data.result == "success") {
			console.log(data.rows);
			
		} else {
			alert(data.notice);
		}
    	
    }).fail(function(request, status, error){
		alert(request.responseJSON.notice);
	});
});


//인기 게시글 슬라이드
var bestSlider = new Swiper("#bestSlider", {
	slidesPerView: 2,
	spaceBetween: 20,
	autoplay: {
		delay: 3500,
		disableOnInteraction: false,
	},
	loop : false,
	loopAdditionalSlides : 1,
	breakpoints: {
		768: {
			slidesPerView: 3,
			spaceBetween: 20,
		},
		1600: {
			slidesPerView: 3,
			spaceBetween: 40,
		},
		2200: {
			slidesPerView: 4,
			spaceBetween: 60,
		},
	},
});


//SNS 슬라이드
var snsSlider = new Swiper("#snsSlider", {
	slidesPerView: 'auto',
	spaceBetween: 10,
	centeredSlides: true,
	slideToClickedSlide : true,
	//autoplay: {
	//	delay: 3500,
	//	disableOnInteraction: false,
	//},
	loop : true,
	loopAdditionalSlides : 1,
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

</script>