<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 이벤트 뷰 페이지 -->
<div class="event-view">
	<div class="title-wrap">
		<h3>텀블러 이용하GO, 커피도 받GO!텀블러 이용하GO, 커피도 받GO!텀블러 이용하GO, 커피도 받GO!</h3>
		<div class="label upcoming">진행예정</div>
	</div>
	<div class="info-wrap wide_con">
		<div class="info">
			<dl>
				<dt>응모기간</dt>
				<dd id="period">2023. 04. 26. ~ 2023. 05. 01</dd>
			</dl>
			<dl>
				<dt>결과발표</dt>
				<dd id="announce">2023. 05. 02.</dd>
			</dl>
			<dl>
				<dt>참여대상</dt>
				<dd id="target">누구나</dd>
			</dl>
			<dl>
				<dt>주최</dt>
				<dd id="host">광주광역시 대변인실</dd>
			</dl>
			<dl>
				<dt>문의처</dt>
				<dd id="inquiry">운영사무국 070-5165-7520</dd>
			</dl>
		</div>
	</div>
	
	<div class="event-content">
		<img style="max-width:100%;" src="/images/noimg_content.jpg" alt="콘텐츠가 없습니다.">
	</div>
	
	<div class="btn-wrap text-center mt55">
		<a href="?contentId=f4d2bc90024029c9815b86cbd951b3213fd2f2b23291ecb84cd7bb3080ccbf31" class="btn-lg btn-line btn-line-02">목록보기 <img src="/thema/basic/images/arrR_bk.png" alt=""></a>
	</div>
</div>

<script>
var pk = "<c:out value='${param.dm_id}'/>";
$(function(){
	if (pk == null || pk == "") {
		alert("잘못된 접근입니다.");
		$(".btn-wrap a").trigger("click");
	} else {
		
		getDetail(pk)
		.done(function(response){
			if (response.result == "success") {
				setDetail(response.rows);
			} else {
				alert(response.notice);
			}
			
		}).fail(function(response, status, error){
			alert(response.responseJSON.notice);
		});		
	}
	
});

var getDetail = function(pk) {
	return $.ajax({
		url: "/web/selectEvent.do",
		data: {
			dm_id: pk
		},
		type: "get"
	});
}

var setDetail = function(rows) {
	var labelClass = "";
	switch (rows.dm_status) {
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
	$(".title-wrap").empty();
	$(".title-wrap").append(
		'<h3>'+rows.dm_title+'</h3>' +
		'<div class="label'+labelClass+'">'+rows.status_text+'</div>'
	);
	
	$("#period").text(rows.dm_event_start + " ~ " + rows.dm_event_end);
	$("#announce").text(rows.dm_announce);
	$("#target").text(rows.dm_target);
	$("#host").text(rows.dm_host);
	$("#inquiry").text(rows.dm_inquiry);
	
	var html = rows.dm_content == "" ? '<img style="max-width:100%;" src="/images/noimg_content.jpg" alt="콘텐츠가 없습니다.">' : rows.dm_content;
	$(".event-content").empty().append(html);
}
</script>