<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	Date today = new Date();
	SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String curDate = transFormat.format(today);
%>
<%@ include file="base.jsp"%>
<c:set var="page" value="${param.page eq null ? 1 : param.page}"/>
<c:set var="curDate" value="<%=curDate%>"/>
<c:set var="ratio" value="${boardVO.dm_gallery_height / boardVO.dm_gallery_width * 100}"/>

<!-- 인기게시물// -->
<div class="favor_con_wrap">
	<!-- .inner// -->
	<div class="inner">
		<!-- 인기검색어// -->
		<div class="favor_keyword">
			<p class="tit t02"># 인기검색어 <i class="fa fa-solid fa-angle-right"></i></p>
			<ul class="keyword_list">
				<li><a href="#">#키워드1</a></li>
				<li><a href="#">#키워드2</a></li>
				<li><a href="#">#키워드3</a></li>
			</ul>
		</div>
		<!-- //인기검색어 -->
		<!-- 리스트// -->
		<div class="favor_list">
			<ul>
				<li>
					<a href="#">
						<div class="img">
							<div class="thumb-wrap"><img src="/thema/basic/images/main/img_test3.jpg" alt="" /></div>
						</div>
						<div class="con_txt">
							<p class="tit t02">장애인 직업 재화지원과 지원순환을 위한 페토너 카트리지 기부장애인 직업 재화지원과 지원순환을 위한 페토너 카트리지 기부</p>
							<div class="bot">
								<p class="vol">vol. 70</p>
								<p class="tag_con"><span class="tag">#민원정보</span><span class="tag">#업무정보</span><span class="tag">#사업분야</span></p>
							</div>
						</div>
					</a>
				</li>
				<li>
					<a href="#">
						<div class="img">
							<div class="thumb-wrap"><img src="/thema/basic/images/main/img_test3.jpg" alt="" /></div>
						</div>
						<div class="con_txt">
							<p class="tit t02">장애인 직업 재화지원과 지원순환을 위한 페토너 카트리지 기부</p>
							<div class="bot">
								<p class="vol">vol. 70</p>
								<p class="tag_con"><span class="tag">#민원정보</span><span class="tag">#업무정보</span><span class="tag">#사업분야</span></p>
							</div>
						</div>
					</a>
				</li>
				<li>
					<a href="#">
						<div class="img">
							<div class="thumb-wrap"><img src="/thema/basic/images/main/img_test3.jpg" alt="" /></div>
						</div>
						<div class="con_txt">
							<p class="tit t02">장애인 직업 재화지원과 지원순환을 위한 페토너 카트리지 기부</p>
							<div class="bot">
								<p class="vol">vol. 70</p>
								<p class="tag_con"><span class="tag">#민원정보</span><span class="tag">#업무정보</span><span class="tag">#사업분야</span></p>
							</div>
						</div>
					</a>
				</li>
			</ul>
		</div>
		<!-- //리스트 -->
	</div>
	<!-- //.inner -->
</div>
<!-- //인기게시물 -->

<c:if test="${boardVO.dm_header_content ne null && boardVO.dm_header_content ne ''}">
	<c:out value="${boardVO.dm_header_content}" escapeXml="false"/>
</c:if>

<!-- bbs// -->
<div class="bbs bbs_list bbs_<c:out value='${boardVO.dm_skin }'/>" id="bbs_<c:out value='${boardVO.dm_table }'/>">
	<!-- .tabMenu-wrap// -->
	<div class="tabMenu-wrap tab-style-02">
		<ul class="nav">
			<li class="nav-item"><button type="button" class="nav-link active" id="tab-con-1" data-toggle="tab" data-target="#tab-content-1" role="tab" aria-controls="tab-content-1" aria-selected="true">전체 콘텐츠 <span><c:out value='${writeListCnt}'/></span></button></li>
			<li class="nav-item"><button type="button" class="nav-link" id="tab-con-2" data-toggle="tab" data-target="#tab-content-2" role="tab" aria-controls="tab-content-2" aria-selected="false">최근 발행호 <span><c:out value="${vol}"/>호</span></button></li>
			<li class="nav-item"><button type="button" class="nav-link" id="tab-con-3" data-toggle="tab" data-target="#tab-content-3" role="tab" aria-controls="tab-content-3" aria-selected="false">많이 본 콘텐츠 </button></li>
			<li class="nav-item"><button type="button" class="nav-link" id="tab-con-4" data-toggle="tab" data-target="#tab-content-4" role="tab" aria-controls="tab-content-4" aria-selected="false">공감 콘텐츠</button></li>
			<li class="nav-item"><button type="button" class="nav-link" id="tab-con-5" data-toggle="tab" data-target="#tab-content-5" role="tab" aria-controls="tab-content-5" aria-selected="false">최신 콘텐츠</button></li>
		</ul>
	</div>
	<!-- //.tabMenu-wrap -->

	<div class="tabContent-wrap">
		<div class="tabContent">
			<!-- 전체 콘텐츠// -->
			<div class="tab-pane fade show active" id="tab-content-1" role="tabpanel" aria-labelledby="tab-con-1">
				<div class="bbs_gallist"></div>
				<div class="bbs_paging"><nav class="pg_wrap"><span class="pg"></span></nav></div>
			</div>
			<!-- //전체 콘텐츠 -->
			<!-- 최근 발행호// -->
			<div class="tab-pane fade" id="tab-content-2" role="tabpanel" aria-labelledby="tab-con-2">
				<div class="bbs_gallist"></div>
				<div class="bbs_paging"><nav class="pg_wrap"><span class="pg"></span></nav></div>
			</div>
			<!-- //최근 발행호 -->
			<!-- 많이 본 콘텐츠// -->
			<div class="tab-pane fade" id="tab-content-3" role="tabpanel" aria-labelledby="tab-con-3">
				<div class="bbs_gallist"></div>
				<div class="bbs_paging"><nav class="pg_wrap"><span class="pg"></span></nav></div>
			</div>
			<!-- //많이 본 콘텐츠 -->
			<!-- 공감 콘텐츠// -->
			<div class="tab-pane fade" id="tab-content-4" role="tabpanel" aria-labelledby="tab-con-4">
				<div class="bbs_gallist"></div>
				<div class="bbs_paging"><nav class="pg_wrap"><span class="pg"></span></nav></div>
			</div>
			<!-- //공감 콘텐츠 -->
			<!-- 최신 콘텐츠// -->
			<div class="tab-pane fade" id="tab-content-5" role="tabpanel" aria-labelledby="tab-con-5">
				<div class="bbs_gallist"></div>
				<div class="bbs_paging"><nav class="pg_wrap"><span class="pg"></span></nav></div>
			</div>
			<!-- //최신 콘텐츠 -->
		</div>
	</div>
</div>
<!-- //bbs -->
<c:if test="${boardVO.dm_footer_content ne null && boardVO.dm_footer_content ne ''}">
	<c:out value="${boardVO.dm_footer_content}" escapeXml="false"/>
</c:if>
<script>
$(function () {
	getContentsList("tab-content-1", 1);
	getContentsList("tab-content-2", 1);
	getContentsList("tab-content-3", 1);
	getContentsList("tab-content-4", 1);
	getContentsList("tab-content-5", 1);
});
//			
var dataPerPage = <c:out value="${boardVO.dm_page_rows}" />;
var pageCount = 5;

function getContentsList(tab, page) {
	switch(tab) {
	  case "tab-content-1": default:
		$.ajax({
			url: "/web/selectWriteListForWeb.do",
			data: {
				"search_board" : "${boardVO.dm_id}",
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
	  case "tab-content-2":
		$.ajax({
			url: "/web/selectWriteListVol.do",
			data: {
				"search_board" : "${boardVO.dm_id}",
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

	  case "tab-content-3":
			$.ajax({
				url: "/web/selectWriteListForWeb.do",
				data: {
					"search_board" : "${boardVO.dm_id}",
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
	  case "tab-content-4":
		$.ajax({
			url: "/web/selectWriteListLike.do",
			data: {
				"search_board" : "${boardVO.dm_id}",
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
	  case "tab-content-5":
		$.ajax({
			url: "/web/selectWriteListForWeb.do",
			data: {
				"search_board" : "${boardVO.dm_id}",
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
	}	
}

function fnSetData(tab, rows) {
	var html = '';
	if (rows.length > 0) {
		html += '<ul class="gall row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">';
		$.each(rows, function(i, obj) {
			html += '<li class="cell col">';
			html += '<a href="${param.root }/index.do?command=view&wr_id='+obj.wr_id+'&amp;${writeSearchQueryString}">';
			html += '<div class="img">';
			if(obj.wr_thumb) {
				html += '<div class="thumb-wrap" style="width: 100%; padding-top: ${ratio }%; background-image: url(\''+obj.wr_path+obj.wr_thumb_sub+'\');"><img src="'+obj.wr_path+obj.wr_thumb_sub+'" alt="'+obj.wr_subject+'" onerror="this.src=\'/images/no_image.png\'"></div>';
			} else {
				html += '<div class="thumb-wrap noimg" style="width: 100%; padding-top: ${ratio }%; background-image: url(\'/images/no_image.png\');"><img src="/images/no_image.png" alt="no image"></div>';
			}
			html += '</div>';
			html += '<div class="con_txt"><p class="tit t02">'+obj.wr_subject+'</p>';
			html += '<div class="bot"><p class="vol">vol. '+obj.wr_vol+'</p>';
			if(obj.hashtag) {
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

    var totalPage = Math.ceil(totalCount/dataPerPage);    // 총 페이지 수
    var pageGroup = Math.ceil(currentPage/pageCount);    // 페이지 그룹
	
   // $("#currentPage").text(totalCount == 0 ? 0 : currentPage);
   // $("#totalPage").text(totalPage);
    
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

        return false;
    });
}
</script>
