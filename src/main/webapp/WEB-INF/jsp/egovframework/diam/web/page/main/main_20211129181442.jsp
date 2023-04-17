<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<section class="main-section sec-best">
	<div class="inner">
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
							<img src="${layout_path}/images/main/main_ban01_m.png" alt="">
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
	<div class="inner">
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
		</div>
		<!-- //.side-content -->
		
		<div class="tabMenu-wrap">
			<ul>
				<li class="tabMenu on" data-value="1">Contents</li>
				<li class="tabMenu" data-value="2">Article</li>
				<li class="tabMenu" data-value="3">Life</li>
			</ul>
		</div>
		<!-- //.tabMenu-wrap -->
		
		<div class="tabContent-wrap">
			<div class="tabContent" data-target="1">
				<div class="grid">
					<div class="grid-sizer"></div>
					<div class="grid-item"><div class="img"><img src="${layout_path}/images/main/sample01.jpg" alt=""></div></div>
					<div class="grid-item"><div class="img"><img src="${layout_path}/images/main/sample02.jpg" alt=""></div></div>
					<div class="grid-item"><div class="img"><img src="${layout_path}/images/main/sample03.jpg" alt=""></div></div>
					<div class="grid-item"><div class="img"><img src="${layout_path}/images/main/sample04.jpg" alt=""></div></div>
					<div class="grid-item"><div class="img"><img src="${layout_path}/images/main/sample05.jpg" alt=""></div></div>
				</div>
				<!-- //.masonry -->
			</div>
			<!-- //.tabContent -->
			<div class="tabContent" data-target="2">Article</div>
			<!-- //.tabContent -->
			<div class="tabContent" data-target="3">Life</div>
			<!-- //.tabContent -->
		</div>
		<!-- //.tabContent-wrap -->
	</div>
	<!-- //.inner -->
</section>
<!-- //.main-section.sec-now -->

<section class="main-section sec-sns" style="display: none;">
	SNS
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
	</div>
	<!-- //.side-content -->
</section>





<section id="latest_list" style="display: none;">
	<h2>iCMS 소식</h2>
	<p class="sub_copy">새로운 소식을 전해드립니다.</p>
	<div class="mt50">
		<div class="latest_contents">
			<div class="board_list_wrap">
				<h4 class="sr-only">최근 게시글 리스트</h4>
				<c:if test="${!empty writeMap }">
					<c:forEach items="${writeMap }" var="entry" varStatus="status">
					 	<div class="latest_box <c:out value='${status.count eq 1 ? "active" : ""}'/>">
					 		<h5><a onclick="javascript:clickMiniBoard(this)"><c:out value="${writeMap[entry.key][0].dm_table_text}"/></a></h5>
					 		<ul>
					 			<c:choose>
									<c:when test="${fn:length(writeMap[entry.key]) > 0 and !empty writeMap[entry.key][0].wr_id}">
								 		<c:forEach var="item" items="${writeMap[entry.key]}">
								 			<li>
								 				<a href="/index.do?contentId=<c:out value='${item.uid }'/>&command=view&wr_id=<c:out value='${item.wr_id }'/>"><c:out value="${item.wr_subject }" escapeXml="false"/></a>
												<span>
									 				<fmt:parseDate value="${item.wr_datetime}" var="registered" pattern="yyyy-MM-dd HH:mm:ss" />
													<fmt:formatDate value="${registered}" pattern="yyyy-MM-dd" />
												</span>
								 			</li>
								 		</c:forEach>
									</c:when>
									<c:otherwise>
										<li>게시글이 없습니다.</li>
									</c:otherwise>
					 			</c:choose>
					 		</ul>
					 		<a href="?contentId=<c:out value='${writeMap[entry.key][0].uid}'/>" class="a-more-05" title="페이지 이동"><span></span></a>
					 	</div>
					</c:forEach>
				</c:if>
			</div>
			
			<div class="banner_list_wrap">
				<h4>배너존</h4>
				<div class="swiper-button-next"><img src="${layout_path}/images/swiper_arrow.png"></div>
				<div class="swiper-button-prev"><img src="${layout_path}/images/swiper_arrow.png"></div>
				<c:choose>
					<c:when test="${fn:length(bannerList) > 0}">
						<div class="swiper-container" id="banSlider">
							<ul class="banner_list swiper-wrapper">
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
										</li>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="no-img" style="background-image: url('/images/no_image.png');">
							<img src="/images/no_image.png" alt="등록된 배너가 없습니다."/>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
</section>

<script>
//탭 레이아웃 리스너
$(".tabMenu").on("click",function(){
    $(".on").removeClass("on").attr("title", " ");
    $(this).addClass("on").attr("title", "선택됨");

    var value = $(this).data("value");
    $("[data-target="+value+"]").show().attr("title", "선택됨");
    $(".tabContent[data-target!="+value+"]").hide().attr("title", " ");
});

$("[data-value=1]").trigger("click");


//인기 게시글 슬라이드
var bestSlider = new Swiper("#bestSlider", {
	slidesPerView: 2,
	spaceBetween: 20,
	autoplay: {
		delay: 3500,
		disableOnInteraction: false, // false-스와이프 후 자동 재생
	},
	loop : true,
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


function clickMiniBoard($this){
	$(".latest_box").removeClass("active");
	$($this).parent().parent().addClass("active");
}
</script>