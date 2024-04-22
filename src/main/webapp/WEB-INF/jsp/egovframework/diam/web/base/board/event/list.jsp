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

<c:if test="${boardVO.dm_header_content ne null && boardVO.dm_header_content ne ''}">
	<c:out value="${boardVO.dm_header_content}" escapeXml="false"/>
</c:if>

<!-- bbs// --> 
<div class="bbs bbs_list bbs_<c:out value='${boardVO.dm_skin }'/>" id="bbs_<c:out value='${boardVO.dm_table }'/>">
	<div class="event-wrap">
		<div class="event-item">
			<a href="#">
				<div class="thumb-container">
					<div class="thumb-wrap" style="background-image: url('/thema/basic/images/pages/sample_event.jpg');">
						<p class="img"><img src="/thema/basic/images/pages/sample_event.jpg" alt="" onerror="this.src=\'/thema/basic/images/pages/no_image.png\'"></p>
						<p class="label proceed"></p>
					</div>
				</div>
				<div class="event-txt">
					<div class="title">이벤트</div>
					<div class="subject"><span class="label">[진행중]</span>ACC & V&A 국제교육협력 글로벌 전문인력워크숍</div>
				</div>
			</a>
		</div>
		<div class="event-item">
			<a href="#">
				<div class="thumb-container">
					<div class="thumb-wrap" style="background-image: url('/thema/basic/images/pages/sample_event.jpg');">
						<p class="img"><img src="/thema/basic/images/pages/sample_event.jpg" alt="" onerror="this.src=\'/thema/basic/images/pages/no_image.png\'"></p>
						<p class="label">종 료</p>
					</div>
				</div>
				<div class="event-txt">
					<div class="title">당첨자발표</div>
					<div class="subject"><span class="label">[종료]</span>2023 ACC아시아콘텐츠 공연개발 시범공연 《식탁과 기억》 -식탁은...</div>
				</div>
			</a>
		</div>
		<div class="event-item">
			<a href="#">
				<div class="thumb-container">
					<div class="thumb-wrap" style="background-image: url('/thema/basic/images/pages/sample_event.jpg');">
						<p class="img"><img src="/thema/basic/images/pages/sample_event.jpg" alt="" onerror="this.src=\'/thema/basic/images/pages/no_image.png\'"></p>
						<p class="label upcoming"></p>
					</div>
				</div>
				<div class="event-txt">
					<div class="title">이벤트</div>
					<div class="subject"><span class="label">[당첨자발표]</span>2023년 아시아 공예 레지던시 프로그램 공예워크숍</div>
				</div>
			</a>
		</div>
	</div>
	<div class="bbs_paging"><nav class="pg_wrap"><span class="pg"></span></nav></div>
</div>
<!-- //bbs -->
<c:if test="${boardVO.dm_footer_content ne null && boardVO.dm_footer_content ne ''}">
	<c:out value="${boardVO.dm_footer_content}" escapeXml="false"/>
</c:if>
<!-- <script>		
	$(function(){
		getList(1);
	});
	
	function getList(page) {
		$.ajax({
			url: "/web/selectEventList.do",
			type: "get",
			data: {
				page: page
			}
		}).done(function(response){
			setList(response.rows);
			
			if (response.total > 0) {
				getPaging(page, response.total);
			}
			
		}).fail(function(request, status, error){
			alert(request.responseJSON.notice);
		});
	}
	
	function setList(data){
		var target = $(".event-wrap");
		target.empty();
		
		var str = "";
		
		if (data.length > 0) {
			$.each(data, function(i, obj) {
				str += '<div class="event-item">';
				str += '<a href="${param.root }/index.do?command=view&wr_id='+obj.wr_id+'&amp;${writeSearchQueryString}">';
				str += '<div class="thumb-container">';
				str += '<div class="thumb-wrap" style="background-image: url(' + "'" + obj.dm_file_path + "'" +');">';
				str += '<p class="img"><img src="'+obj.dm_file_path+'" alt="" onerror="this.src=\'/images/no_image.png\'"></p>';
				str += '<p class="label'+labelClass+'">'+obj.status_text+'</p>';
				str += '</div>';
				str += '</div>';
				str += '<div class="event-txt">';
				var labelClass = "";
				switch (obj.dm_status) {
				case "1":
					labelClass = " proceed";
					break;
				case "2":
					labelClass = " upcoming";
					break;
				default: 
					labelClass = "";
					break;
				}
				str += '<div class="label'+labelClass+'">'+obj.status_text+'</div>';
				str += '<div class="subject">'+obj.dm_title+'</div>';
				str += '</div>';
				str += '</a>';
				str += '</div>';
			});
		} else {
			// 릳스트 없을때
		}
		
		target.append(str);
	}
	
	function getPaging(page, total){
		
		var url = "";
		var element = $(".page-wrap");
		element.empty();
		var pageCount = Math.ceil(total / 6);
		
		var pageSection = page % 10 == 0;
		if (pageSection) {
			pageSection = page / 10;
		} else {
			pageSection = page / 10 + 1;
		}
		pageSection = parseInt(pageSection);
		
		var startPage = pageSection * 10 - 9;
	 	var str = "";
		if (pageSection != 1) {
			str += '<a class="pg_page pg_prev" data-page="'+(startPage - 1) + '"></a>';
		}
		
		for (var i = startPage; i <= pageCount; i++) {
			if (i > pageSection * 10) {
				break;
			}
			if (i == page) {
				str += '<span class="pg_current"><page-number>'+i+'</page-number></span>';
			} else {
				str += '<a class="pg_page" data-page="'+i+'"><page-number>'+i+'</page-number><span class="sr-only">페이지</span></a>';
			}
		}
		if (pageSection * 10 < pageCount) {
			str += '<a class="pg_page pg_next" data-page="' +(pageSection * 10 + 1)+ '"></a>';
		}
		element.append(str);
	}
	
	$(document).on("click", ".pg_page", function(e) {
		e.preventDefault();
		
		var thisPage = $(this).data("page");
		getList(thisPage);
		
		$("html, body").animate({scrollTop: 0}, 300);
	    return false;
	});
</script> -->
