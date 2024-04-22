<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.page-wrap {
		margin: 40px 0 0;
		text-align: center;
	}
</style>
<!-- 이벤트 페이지 -->
<div class="event-wrap">
</div>
<div class="page-wrap">
</div>
<script>

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
			str += '<a href="?contentId=257a1626ad31a8264c62ddc8ad0454247da258be5f3f6def89c5bb96d6da80bf&dm_id='+obj.dm_id+'">';
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
			str += '<div class="info">';
			str += '<dl class="term">';
			str += '<dt>응모기간</dt>';
			str += '<dd>'+obj.dm_event_start + ' ~ ' + obj.dm_event_end+'</dd>';
			str += '</dl>';
			str += '<dl>';
			str += '<dt>결과발표</dt>';
			str += '<dd>'+obj.dm_announce+'</dd>';
			str += '</dl>';
			str += '<dl>';
			str += '<dt>참여대상</dt>';
			str += '<dd>'+obj.dm_target+'</dd>';
			str += '</dl>';
			str += '</div>';
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
</script>