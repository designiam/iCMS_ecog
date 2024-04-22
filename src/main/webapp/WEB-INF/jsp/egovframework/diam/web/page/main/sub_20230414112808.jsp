<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
	.menutab .dep-wrap { display:none; }
	#vis #titler .leader { display:none; }
</style>

<!-- 호별선택// -->
<div class="select_total_box">
	<div class="inner">
		<!-- select_con// -->
		<div class="select_con">
			<div class="area-custom-select" id="custom-select-year">
				<div class="custom-select" tabindex="0">
					<span class="custom-select-text">2024년</span>
					<img src="${layout_path}/images/pages/ico_arrow_sel.png" class="custom-select-arrow">
				</div>
				<ul class="custom-select-list" id="custom-select-list" style="display:none;">
				</ul>
			</div>
			<div class="area-custom-select" id="custom-select-vol">
				<div class="custom-select" tabindex="0">
					<span class="custom-select-text-vol">71호</span>
					<img src="${layout_path}/images/pages/ico_arrow_sel.png" class="custom-select-arrow">
				</div>
				<ul class="custom-select-list" id="custom-select-list-vol" style="display:none;">
				</ul>
			</div>
			<!-- //.area-custom-select -->
		</div>
		<!-- //select_con -->
		<!-- 전체호_최근발행호// -->
		<div class="total_latest">
			<p class="total_vol">전체 호 <span>200</span></p>
			<p class="latest_vol">최근 발행호 <span>${sessionScope.vol}호</span></p>
		</div>
		<!-- //전체호_최근발행호 -->
	</div>
</div>
<!-- //호별선택 -->

<div class="bbs_gallist vol_list">
	<ul class="gall row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
	</ul>
	<!-- 내용더보기// -->
	<div class="more_con">
		<a href="#"><span class="sr-only">내용 더보기</span></a>
	</div>
	<!-- //내용더보기 -->
</div>

<script>

var selectFlag;
var selectVolFlag;

// select box 오픈 리스너
$(document).on('click','#custom-select-year > .custom-select', function() {
	$(this).toggleClass('selected');
	if($(this).hasClass('selected')) {
		$('#custom-select-list').slideDown();
	} else {
		$('#custom-select-list').slideUp();
	}
});



// 옵션 클릭 리스너
$(document).on('click','#custom-select-list li', function() {
	var value = $(this).attr('value');
	console.log(value);
	$('.custom-select-text').html($(this).html());
	$('#custom-select-list').slideUp();
	
	getComboListVol($(this).data("year"));
});

//select box 오픈 리스너
$(document).on('click','#custom-select-vol > .custom-select', function() {
	$(this).toggleClass('selected');
	if($(this).hasClass('selected')) {
		$('#custom-select-list-vol').slideDown();
	} else {
		$('#custom-select-list-vol').slideUp();
	}
});


//옵션 클릭 리스너
$(document).on('click','#custom-select-list-vol li', function() {
	var value = $(this).attr('value');
	console.log($(this).html());
	$('.custom-select-text-vol').html($(this).html());
	$('#custom-select-list-vol').slideUp();
	
	getWriteList($(this).data("vol"));
});

var getWriteList = function(uniq) {
	$.ajax({
		url : "/web/selectSameVolWrite.do",
		data : {
			wr_vol : uniq
		},
		type : "get"
	}).done(function(response){
		setWriteList(response.rows);
	}).fail(function(response, status, error){
		alert(response.responseJSON.notice);
	});
}

var setWriteList = function(rows) {
	var str = "";
	if (rows.length > 0) {
		$.each(rows, function(i, obj) {
			str += '<li class="cell col">';
			//str += '<a href="?contentId='+obj.uid+'">';
			str += '<a href="?contentId='+obj.uid+'&command=view&wr_id='+obj.wr_id+'">';
			str += '<div class="info">';
			str += '<p class="tit"><em>vol. <span class="vol_num">'+obj.wr_vol+'</span></em><span class="date">'+obj.wr_year+'-'+obj.wr_month+'</span></p>';
			str += '<p class="logo"><img src="${layout_path}/images/pages/img_logo.png" alt="함께green광주(광주환경공단이 만드는 환경저널)" /></p>';
			str += '</div>';
			str += '<div class="cell_thumb img">';
			if (obj.wr_thumb_sub == null) {
				str += '<div class="thumb-wrap" style="background-image: url(\'/images/no_image.png\');">';				
			} else {
				str += '<div class="thumb-wrap" style="background-image: url(\''+obj.wr_path + obj.wr_thumb_sub+'\');">';				
			}
			//str += '<div class="thumb-wrap" style="background-image: url(\''+obj.wr_path + obj.wr_thumb_sub+'\');">';
			str += '<img src="'+ obj.wr_path + obj.wr_thumb_sub +'" alt="" onerror="this.src=\'/images/no_image.png\'">';
			str += '</div>';
			str += '</div>';
			str += '</a>';
			str += '</li>';
		});
	} else {
		str += '<li style="max-width: 100%; flex: 100%;"><img style="max-width:100%;" src="/images/noimg_content.jpg" alt="콘텐츠가 없습니다."></li>';
	}
	
	$(".gall").empty().append(str);
}

$(function() {
	getComboListYear();
	getCoverTotalCount();
});

var getComboListYear = function() {
	$.ajax({
		url : "/web/selectCoverComboboxYear.do",
		type: "get"
	}).done(function(response){
		if (response.result == "success") {
			setComboListYear(response.rows)
		}
	}).fail(function(response, status, error){
		alert(response.responseJSON.notice);
	});
}
var getComboListVol = function(year) {
	
	$.ajax({
		data : {"dm_year" : year},
		url : "/web/selectCoverComboboxVol.do",
		type: "get"
	}).done(function(response){
		if (response.result == "success") {
			setComboListVol(response.rows)
		}
	}).fail(function(response, status, error){
		alert(response.responseJSON.notice);
	});
}
var setComboListYear = function (rows) {
	var str = "";
	if (rows.length > 0) {
		$.each(rows, function(i, obj){
			str += '<li data-year="'+obj.dm_year+'" value="selectOption'+(i + 1)+'" class="custom-select-option">'+obj.dm_year + "년"+'</li>';
		});
	} else {
		str += '<li value="selectOption1" class="custom-select-option">데이터가 없습니다.</li>';
	}
	
	$("#custom-select-list").empty().append(str);
	$("#custom-select-list").find("li").eq(0).trigger("click");
}

var setComboListVol = function (rows) {
	var str = "";
	if (rows.length > 0) {
		$.each(rows, function(i, obj){
			str += '<li data-vol="'+obj.dm_vol+'" value="selectOption'+(i + 1)+'" class="custom-select-option vol">'+obj.dm_vol + "호"+'</li>';
		});
	} else {
		str += '<li value="selectOption1" class="custom-select-option vol">데이터가 없습니다.</li>';
	}
	
	$("#custom-select-list-vol").empty().append(str);
	
	$("#custom-select-list-vol").find("li").eq(0).trigger("click");
}

var getCoverTotalCount = function() {
	$.ajax({
		url : "/web/selectCoverTotalCount.do",
		type: "get"
	}).done(function(response){
		if (response.result == "success") {
			$(".total_vol > span").text(response.rows);
		}
	}).fail(function(response, status, error){
		alert(response.responseJSON.notice);
	});
}
</script>