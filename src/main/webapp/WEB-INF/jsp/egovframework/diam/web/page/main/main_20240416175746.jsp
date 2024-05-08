<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 최신 발행호 중 3개 콘텐츠 슬라이드// -->
<!-- topSlider// -->
<div id="topSlider">
	<c:import url="/portlet.do">
		<c:param name="MODE" value="mainVisual" />
		<c:param name="VIEW" value="portlet/mainVisual" />
	</c:import>
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

<!-- 월간BEST_추천콘텐츠// -->
<div id="top_con_slide">
	<!-- .inner// -->
	<div class="inner">
		<div class="tabMenu-wrap tab-style-02">
			<ul class="nav">
				<li class="nav-item"><button type="button" class="nav-link active" id="tab-con1-1" data-toggle="tab" data-target="#tab-content-1-1" role="tab" aria-controls="tab-content-1-1" aria-selected="true">월간 BEST</button></li>
				<li class="nav-item"><button type="button" class="nav-link" id="tab-con1-2" data-toggle="tab" data-target="#tab-content-1-2" role="tab" aria-controls="tab-content-1-2" aria-selected="false">추천콘텐츠</button></li>
			</ul>
		</div>
		<!-- //.tabMenu-wrap -->
	
		<div class="tabContent-wrap">
			<div class="tabContent">
				<!-- 월간 BEST// -->
				<div class="tab-pane fade show active" id="tab-content-1-1" role="tabpanel" aria-labelledby="tab-con1-1">
					<div class="slide_top_wrap">
						<div class="sld-wrp">
							<div class="slider_for_wrap">
								<div class="slider-for">
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
							</div>
						</div>
					</div>

				</div>
				<!-- //월간 BEST -->
				<!-- 추천콘텐츠// -->
				<div class="tab-pane fade" id="tab-content-1-2" role="tabpanel" aria-labelledby="tab-con1-2">
					<div class="slide_top_wrap">
						<div class="sld-wrp">
							<div class="slider_for_wrap">
								<div class="slider-for">
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
							</div>
						</div>
					</div>

				</div>
				<!-- //추천콘텐츠 -->
			</div>
		</div>
		<!-- //.tabContent-wrap -->
	</div>
	<!-- //.inner -->
</div>
<!-- //월간BEST_추천콘텐츠 -->

<!-- 콘텐츠 전체보기// -->
<div id="contents_all">
	<div class="tab_menu_con">
		<div class="tabMenu-wrap tab-style-02">
			<ul class="nav">
				<li class="nav-item"><button type="button" class="nav-link active" id="tab-con2-1" data-toggle="tab" data-target="#tab-content-2-1" role="tab" aria-controls="tab-content-2-1" aria-selected="true">전체 콘텐츠</button></li>
				<li class="nav-item"><button type="button" class="nav-link" id="tab-con2-2" data-toggle="tab" data-target="#tab-content-2-2" role="tab" aria-controls="tab-content-2-2" aria-selected="false">최근 발행호 <span>${sessionScope.vol}호</span></button></li>
				<li class="nav-item"><button type="button" class="nav-link" id="tab-con2-3" data-toggle="tab" data-target="#tab-content-2-3" role="tab" aria-controls="tab-content-2-3" aria-selected="false">많이 본 콘텐츠</button></li>
			</ul>
		</div>
		<!-- //.tabMenu-wrap -->
		<!-- <div class="last_view"><a href="?contentId=abb7c68a0900d318989c201245657cf7433701a9ff1e317f7043ac8aaebebbb4" class="t05">지난호 보기 <i class="fas fa-sharp fa-thin fa-chevron-right"></i></a></div> -->
	</div>
	<!-- //.tab_menu_con -->
	<!-- .inner// -->
	<div class="inner">	
		<div class="tabContent-wrap">
			<div class="tabContent">
				<!-- 전체 콘텐츠// -->
				<div class="tab-pane fade show active" id="tab-content-2-1" role="tabpanel" aria-labelledby="tab-con2-1">
					<div class="bbs_gallist"></div>
					<div class="bbs_paging mt0"><nav class="pg_wrap"><span class="pg"></span></nav></div>
				</div>
				<!-- //전체 콘텐츠 -->
				<!-- 최근 발행호// -->
				<div class="tab-pane fade" id="tab-content-2-2" role="tabpanel" aria-labelledby="tab-con2-2">
					<div class="bbs_gallist"></div>
					<div class="bbs_paging mt0"><nav class="pg_wrap"><span class="pg"></span></nav></div>
				</div>
				<!-- //최근 발행호 -->
				<!-- 많이 본 콘텐츠// -->
				<div class="tab-pane fade" id="tab-content-2-3" role="tabpanel" aria-labelledby="tab-con2-3">
					<div class="bbs_gallist"></div>
					<div class="bbs_paging mt0"><nav class="pg_wrap"><span class="pg"></span></nav></div>
				</div>
				<!-- //많이 본 콘텐츠 -->
			</div>
		</div>
		<!-- //.tabContent-wrap -->
	</div>
	<!-- //.inner -->
</div>
<!-- //콘텐츠 전체보기 -->


<!-- 지난호보기// -->
<div id="webzine_last_view">
	<div class="inner">
		<div class="con_txt">
			<p class="txt">지난 호 콘텐츠가 궁금하다면?</p>
			<p class="tit">지난호 보기</p>
			<p class="btn_con"><a href="?contentId=abb7c68a0900d318989c201245657cf7433701a9ff1e317f7043ac8aaebebbb4" class="btn_go">바로가기 <i class="fas fa-thin fa-arrow-right"></i></a></p>
		</div>
	</div>
</div>
<!-- //지난호보기 -->

<!-- 이벤트_sns로 만나는 광주환경공단// -->
<div id="event_sns">
	<div class="inner">
		<div class="event_con">
			<p class="tit h04">EVENT</p>
			<p class="img"><img src="/thema/basic/images/main/img_test2.jpg" alt="" /></p>
		</div>
		<div class="sns_con">
			<p class="tit h04">SNS로 만나는 광주환경공단</p>
			<ul>
				<li id="snsInstagram">
					<a href="#">
						<span class="icon insta">인스타그램</span>
						<img src="/thema/basic/images/main/img_test2.jpg" alt="" />
					</a>
				</li>
				<li id="snsFacebook">
					<a href="#">
						<span class="icon face">페이스북</span>
						<img src="/thema/basic/images/main/img_test2.jpg" alt="" />
					</a>
				</li>
				<li id="snsYoutube">
					<a href="#">
						<span class="icon youtube">유튜브</span>
						<img src="/thema/basic/images/main/img_test2.jpg" alt="" />
					</a>
				</li>
				<li id="snsBlog">
					<a href="#">
						<span class="icon blog">네이버블로그</span>
						<img src="/thema/basic/images/main/img_test2.jpg" alt="" />
					</a>
				</li>
			</ul>
		</div>
	</div>
</div>
<!-- //이벤트_sns로 만나는 광주환경공단 -->
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/slickslider/slick.min.js'/>"></script>
<script>
function sliderSet(slickID) {
	$(slickID + " .slider-for").slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: true,
		autoplay: true,
		autoplaySpeed : 3000,
		lazyLoad: 'progressive',
		infinite: true,
		infiniteSlide: 0,
		asNavFor: slickID + " .slider-nav",
		prevArrow : $(slickID + ' .prevArrow'), 
		nextArrow : $(slickID + ' .nextArrow'),
	});
	$(slickID + " .slider-nav").slick({
		vertical: true,
		slidesToShow: 3,
		slidesToScroll: 1,
		arrows: false,
		asNavFor: slickID + " .slider-for",
		centerMode: false,
		autoplay: false,
		swipe: false,
		focusOnSelect: true
	});
	$(slickID + " .slider-for").on('init reInit afterChange', function(event, slick, currentSlide, nextSlide){ 
		var i = (currentSlide ? currentSlide : 0) + 1;
		$(slickID + " .sPage1").html("<span class='now'>"+i+"</span><span> / "+slick.slideCount+"</span>");
	});
	// 재생/정지 버튼 컨트롤
	$(slickID + " .play").click(function(){
		$(slickID + " .slider-for").slick('slickPlay');
	}); 
	$(slickID + " .stop").click(function(){
		$(slickID + " .slider-for").slick('slickPause');
	});
	$(".slider").not('.slick-initialized').slick();
}
</script>
<script>
/* $(function() {
	//최신 발행호
	var topSlider = new Swiper( '#topSlider', {
		slidesPerView: 'auto',
		speed: 3000,
		//allowTouchMove:true,
		//loop: true,
		autoplay: {
		//delay: 3000,
		autoplayDisableOnInteraction: false,
		disableOnInteraction: false,
		pauseOnMouseEnter:true,
		},
		
		navigation: {
			nextEl: '#topSlider .swiper-button-next',
			prevEl: '#topSlider .swiper-button-prev',
		},
	});
}); */
</script>

<script>
//월간 BEST
function getPopularData() {
	var slickID = "#tab-content-1-1";
	
	$.ajax({
		url: "/web/selectPopularWrite.do",
		data: {wr_vol : "${sessionScope.vol}"},
		type: "get",
		dataType : "json",
		success : function (res) {
			if(res.result == "success") {		
				if (res.rows.length > 0) {
					var slide_con1 = '';
					var slide_con2 = '';
					
					$.each(res.rows, function(i, obj){
						var typeClass = "";
						switch(obj.wr_board) {
						case "56":
							typeClass = "type_1";
							break;
						case "43":
							typeClass = "type_2";
							break;
						case "44":
							typeClass = "type_3";
							break;
						}
						
						slide_con1 +='<div class="slide-container">';
						slide_con1 +='<a href="?contentId='+obj.uid+'&wr_id='+obj.wr_id+'&command=view">';
						slide_con1 +='<div class="img_con">';
						slide_con1 +='<p class="img" style="width: 100%; background-image: url(\''+obj.wr_path+obj.wr_thumb_sub+'\');"><img src="'+obj.wr_path+obj.wr_thumb_sub+'" alt="'+obj.wr_subject+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></p>';
						slide_con1 +='</div>';
						slide_con1 +='</a>';
						slide_con1 +='</div>';
		
						
						slide_con2 +='<div class="slide-btn">';
						slide_con2 +='<div class="thumb_img"><img src="'+obj.wr_path+obj.wr_thumb_sub+'" alt="'+obj.wr_subject+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></div>';
						slide_con2 +='<div class="thumb_txt"><p class="type '+typeClass+'">'+obj.type+'</p>';
						slide_con2 +='<p class="t04">'+obj.wr_subject+'</p>';
						slide_con2 +='</div>';
						slide_con2 +='</div>';
					});
		
					$(slickID + " .slider-for").empty().append(slide_con1);
					$(slickID + " .slider-nav").empty().append(slide_con2);
					
					sliderSet(slickID);
				}
			}
		}, error:function(request,status,error) {
			alert(request.responseJSON.notice);
		}
	});
}

//추천 콘텐츠
function getRecommendData() {
	var slickID = "#tab-content-1-2";
	
	$.ajax({
		url: "/web/selectRecommendWrite.do",
		data: {wr_vol : "${sessionScope.vol}"},
		type: "get",
		dataType : "json",
		success : function (res) {
			if(res.result == "success") {		
				if (res.rows.length > 0) {
					var slide_con1 = '';
					var slide_con2 = '';
					
					$.each(res.rows, function(i, obj){
						var typeClass = "";
						switch(obj.wr_board) {
						case "56":
							typeClass = "type_1";
							break;
						case "43":
							typeClass = "type_2";
							break;
						case "44":
							typeClass = "type_3";
							break;
						}
						
						slide_con1 +='<div class="slide-container">';
						slide_con1 +='<a href="?contentId='+obj.uid+'&wr_id='+obj.wr_id+'&command=view">';
						slide_con1 +='<div class="img_con">';
						slide_con1 +='<p class="img" style="width: 100%; background-image: url(\''+obj.wr_path+obj.wr_thumb_sub+'\');"><img src="'+obj.wr_path+obj.wr_thumb_sub+'" alt="'+obj.wr_subject+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></p>';
						slide_con1 +='</div>';
						slide_con1 +='</a>';
						slide_con1 +='</div>';
		
						
						slide_con2 +='<div class="slide-btn">';
						slide_con2 +='<div class="thumb_img"><img src="'+obj.wr_path+obj.wr_thumb_sub+'" alt="'+obj.wr_subject+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></div>';
						slide_con2 +='<div class="thumb_txt"><p class="type '+typeClass+'">'+obj.type+'</p>';
						slide_con2 +='<p class="t04">'+obj.wr_subject+'</p>';
						slide_con2 +='</div>';
						slide_con2 +='</div>';
					});
		
					$(slickID + " .slider-for").empty().append(slide_con1);
					$(slickID + " .slider-nav").empty().append(slide_con2);
					
					sliderSet(slickID);
				}
			}
		}, error:function(request,status,error) {
			alert(request.responseJSON.notice);
		}
	});
}
</script>

<script>
$(function () {
	getPopularData();
	getRecommendData();
	
	getContentsList("tab-content-2-1", 1);
	getEventData();
	//getCrawlData();
	getInstaData();
	getFacebookData();
	getYoutubeData();
	getBlogData();
});

$(document).on('click','#tab-con2-1', function() {
	getContentsList("tab-content-2-1", 1);
});

$(document).on('click','#tab-con2-2', function() {
	getContentsList("tab-content-2-2", 1);
});

$(document).on('click','#tab-con2-3', function() {
	getContentsList("tab-content-2-3", 1);
});

var dataPerPage = 12;
var pageCount = 5;

function getContentsList(tab, page) {
	switch(tab) {
	  case "tab-content-2-1": default:
		$.ajax({
			url: "/web/selectWriteListForMain.do",
			data: {
				"rows" : dataPerPage,
				"page" : page,
				"sort" : "new"
			},
			type: "get",
			dataType : "json",
			success : function (res) {
				if(res.result == "success") {
					var totalCount = res.total;
					fnSetData(tab, res.rows);
					paging(tab, totalCount, dataPerPage, pageCount, page);
				}
			}, error:function(request,status,error) {
				alert(request.responseJSON.notice);
			}
		});
		break;
	  case "tab-content-2-2":
		$.ajax({
			url: "/web/selectWriteListVol.do",
			data: {
				"wr_vol" : "${sessionScope.vol}",
				"rows" : dataPerPage,
				"page" : page
			},
			type: "get",
			dataType : "json",
			success : function (res) {
				if(res.result == "success") {
					var totalCount = res.total;
					fnSetData(tab, res.rows);
					paging(tab, totalCount, dataPerPage, pageCount, page);
				}
			}, error:function(request,status,error) {
				alert(request.responseJSON.notice);
			}
		});
		break;

	  case "tab-content-2-3":
			$.ajax({
				url: "/web/selectWriteListForMain.do",
				data: {
					"rows" : dataPerPage,
					"page" : page,
					"sort" : "pop"
				},
				type: "get",
				dataType : "json",
				success : function (res) {
					if(res.result == "success") {
						var totalCount = res.total;
						fnSetData(tab, res.rows);
						paging(tab, totalCount, dataPerPage, pageCount, page);
					}
				}, error:function(request,status,error) {
					alert(request.responseJSON.notice);
				}
			});
			break;
	}	
}

function fnSetData(tab, rows) {
	var html = '';
	if (rows.length > 0) {
		html += '<ul class="gall row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">';
		$.each(rows, function(i, obj) {
			var typeClass = "";
			switch(obj.wr_board) {
			case "56":
				typeClass = "type_1";
				break;
			case "43":
				typeClass = "type_2";
				break;
			case "44":
				typeClass = "type_3";
				break;
			}
			html += '<li class="cell col">';
			html += '<a href="${param.root }/index.do?contentId='+obj.uid+'&wr_id='+obj.wr_id+'&command=view">';
			html += '<div class="img">';
			if(obj.wr_thumb_sub) {
				html += '<div class="thumb-wrap" style="width: 100%; padding-top: ${ratio }%; background-image: url(\''+obj.wr_path+obj.wr_thumb_sub+'\');"><img src="'+obj.wr_path+obj.wr_thumb_sub+'" alt="'+obj.wr_subject+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"></div>';
			} else {
				html += '<div class="thumb-wrap noimg" style="width: 100%; padding-top: ${ratio }%; background-image: url(\'${layout_path}/images/pages/no_image.png\');"><img src="${layout_path}/images/pages/no_image.png" alt="no image"></div>';
			}
			html += '</div>';
			html += '<div class="con_txt">';
			html += '<p class="type '+typeClass+'">'+obj.type+'</p>';
			html += '<p class="tit t02">'+obj.wr_subject+'</p>';
			html += '<div class="bot"><p class="vol">vol. '+obj.wr_vol+'</p>';
			if(obj.wr_hashtag) {
				html += '<p class="tag_con">';
				var hashtag = obj.wr_hashtag.split('#');
				var tagcount = 0;
				$.each(hashtag, function(j, tag) {
					if($.trim(tag)!='' && tagcount < 3) {
						html +='<span class="tag">#'+$.trim(tag)+'</span>';
						tagcount++;
					}
				});
				html += '</p>';
			}
			html += '</div></div>';
			html += '</a>';
			html += '</li>';
		});
		html += '</ul>';
	} else {
		html += '<p class="empty"><img src="../images/noimg_content.jpg" alt="콘텐츠가 없습니다."></p>';
	}
	$("#"+tab+" > .bbs_gallist").empty().append(html);
}

/* 페이징 처리 함수  ****************************************************************************************************************************/
function paging(tab, totalCount, dataPerPage, pageCount, currentPage) {

    var totalPage = Math.ceil(totalCount / dataPerPage);
    var pageGroup = Math.ceil(currentPage / pageCount);
	
    var last = pageGroup * pageCount;    // 화면에 보여질 마지막 페이지 번호

    if(last > totalPage)
        last = totalPage;
    var first = last - (pageCount-1);    // 화면에 보여질 첫번째 페이지 번호

    if( first <= 0 ) first = 1;	// 화면에 보여질 개수보다 작은 경우 1 로 세팅

    var next = last+1;
    var prev = first-1;
    var $pagingView = $("#"+tab+" > .bbs_paging > .pg_wrap > .pg");

    var html = '';

    if(prev > 0) {
    	html += '<a href="javascript:void(0);" id="pageFirst" class="pg_page pg_start">처음</a>';
    	html += '<a href="javascript:void(0);" id="pagePrev" class="pg_page pg_prev pg_must"><span>이전</span><page-number>'+prev+'</page-number><span>페이지</span></a>';
    }
    
    for(var i=first; i <= last; i++) {
    	if(i == currentPage) {
            html += '<span class="pg_current pg_must"><span class="sr-only">열린</span><page-number>'+i+'</page-number><span class="sr-only">페이지</span></span>';
    	} else {
            html += '<a href="javascript:void(0);" id="'+i+'" class="pg_page pg_must"><page-number>'+i+'</page-number><span class="sr-only">페이지</span></a>';
    	}
    }

    if(last < totalPage) {
    	html += '<a href="javascript:void(0);" id="pageNext" class="pg_page pg_next"><span>다음&gt;</span><page-number>'+next+'</page-number><span>페이지</span></a>';
    	html += '<a href="javascript:void(0);" id="pageLast" class="pg_page pg_end">맨끝</a>';
    }
    
    $pagingView.html(html);    // 페이지 목록 생성

	$pagingView.children("a").click(function() {
        var $item = $(this);
        var $id = $item.attr("id");
        var selectedPage = $id; //$item.children('page-number').text();

        if($id == "pageNext")    selectedPage = next;
        else if($id == "pagePrev")    selectedPage = prev;
        else if($id == "pageFirst")   selectedPage = 1;
        else if($id == "pageLast")   selectedPage = totalPage;

        getContentsList(tab, selectedPage);
		if(selectedPage > 1) {
			var offset = $("#"+tab+" > .bbs_gallist").offset();
			$("html, body").animate({scrollTop: offset.top},400);
		}

        return false;
    });
}
var getEventData = function(){
	$.ajax({
		url: "/web/selectWriteForEvent.do",
		data: { "rows" : 1	},
		type: "get",
		dataType : "json",
		success : function (res) {
			if(res.result == "success") {
				var html = '';
				if(res.rows) {
					var obj = res.rows;
					html += '<a href="${param.root }/index.do?contentId='+obj.uid+'&wr_id='+obj.wr_id+'&command=view">';
					html += '<img src="'+obj.wr_path+obj.wr_thumb+'" alt="'+obj.wr_subject+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"/>';
					html += '</a>';
				} 
				$(".event_con > .img").html(html);
			}
		}, error:function(request,status,error) {
			console.log(request.responseJSON.notice);
		}
	});
}
var getBlogData = function(){
	$.ajax({
		url: "/web/selectSnsBlog.do",
		type: "get",
		dataType : "json",
		success : function (res) {
			if(res.result == "success") {
				var html = '';
				if(res.rows.length > 0) {
					var obj = res.rows[0];
					html += '<a href="'+obj.link+'" target="_blank">';
					html += '<span class="icon blog">네이버블로그</span>';
					html += '<img src="'+obj.imgSrc+'" alt="'+obj.title+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"/>';
					html += '</a>';
				} 
				$("#snsBlog").html(html);
			}
		}, error:function(request,status,error) {
			console.log(request.responseJSON.notice);
		}
	});
}
var getYoutubeData = function() {
	$.ajax({
		url: "/web/selectSnsYoutube.do",
		type: "get",
		dataType : "json",
		success : function (res) {
			if(res.result == "success") {
				var html = '';
				if(res.rows.length > 0) {
					var obj = res.rows[0];
					html += '<a href="'+obj.link+'" target="_blank">';
					html += '<span class="icon youtube">유튜브</span>';
					html += '<img src="'+obj.imgSrc+'" alt="'+obj.title+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"/>';
					html += '</a>';
				} 
				$("#snsYoutube").html(html);
			}
		}, error:function(request,status,error) {
			console.log(request.responseJSON.notice);
		}
	});
}
var getFacebookData = function() {
	$.ajax({
		url : "/web/selectSnsFacebook.do",
		type: "get",
		dataType : "json",
		success : function (res) {
			if(res.result == "success") {
				var html = '';
				if(res.rows.length > 0) {
					var obj = res.rows[0];
					html += '<a href="'+obj.link+'" target="_blank">';
					html += '<span class="icon face">페이스북</span>';
					html += '<img src="'+obj.imgSrc+'" alt="'+obj.title+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"/>';
					html += '</a>';
				} 
				$("#snsFacebook").html(html);
			}
		}, error:function(request,status,error) {
			console.log(request.responseJSON.notice);
		}
	});
}
var getInstaData = function() {
	$.ajax({
		url : "/web/selectSnsInsta.do",
		type: "get",
		dataType : "json",
		success : function (res) {
			if(res.result == "success") {
				var html = '';
				if(res.rows.length > 0) {
					var obj = res.rows[0];
					html += '<a href="'+obj.link+'" target="_blank">';
					html += '<span class="icon insta">인스타그램</span>';
					html += '<img src="'+obj.imgSrc+'" alt="'+obj.title+'" onerror="this.src=\'${layout_path}/images/pages/no_image.png\'"/>';
					html += '</a>';
				} 
				$("#snsInstagram").html(html);
			}
		}, error:function(request,status,error) {
			console.log(request.responseJSON.notice);
		}
	});
}

/*
 
var getCrawlData = function(){
	$.ajax({
		url : "/web/selectCrawlData.do",
		type: "get"
	}).done(function(response){
		//setYoutube(response.youtube);
		setInstagram(response.insta);
	}).fail(function(response, status, error){
		alert(response.responseJSON.notice);
	});
}
 
function setInstagram(rows) {
	var target = $("#snsInstagram");
	if (rows.length > 0) {
		target.empty();
		var str = "";
		var obj = rows[0];
		str += '<a target="_blank" href="'+obj.dm_href+'"><span class="icon insta">인스타그램</span><img src="'+obj.dm_src+'" alt="인스타그램 게시물"></a>';
		target.append(str);
	}
}


function setYoutube(data) {
	if (data.dm_href != "" && data.dm_href != null) {
		var uniq = data.dm_href.split("?v=")[1];
		var str = '';
		str += '<a target="_blank" href="https://www.youtube-nocookie.com/embed/'+uniq+'?controls=0">';
		str += '<span class="icon youtube">Youtube</span><img src="https://img.youtube.com/vi/'+uniq+'/hqdefault.jpg" /></a>';
		$("#snsYoutube").empty().append(str);
	}
}
*/
</script>