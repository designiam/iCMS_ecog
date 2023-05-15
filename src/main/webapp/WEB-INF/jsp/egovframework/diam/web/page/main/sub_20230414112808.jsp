<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 지난호 보기 -->

<div class="area-custom-select">
	<div class="custom-select" tabindex="0">
		<span class="custom-select-text"><strong>Vol.02</strong>2023.05</span>
		<img src="${layout_path}/images/pages/select_arrow.png" class="custom-select-arrow">
	</div>
	<ul class="custom-select-list" style="display:none;">
	</ul>
</div>
<!-- //.area-custom-select -->

<div class="bbs_gallist mt60">
	<ul class="gall row row-cols-2 row-cols-sm-2 row-cols-md-3 row-cols-lg-3">
	</ul>
</div>

<script>

var selectFlag;

// select box 오픈 리스너
$(document).on('click','.custom-select', function() {
	$(this).toggleClass('selected');
	if($(this).hasClass('selected')) {
		$('.custom-select-list').slideDown();
	} else {
		$('.custom-select-list').slideUp();
	}
});

$('.custom-select').on('focusin', function() {
	$('.custom-select-list').slideDown();
});

$('.custom-select').on('focusout', function() {
	if(!selectFlag) {
		$('.custom-select-list').slideUp();
	}
	$(this).removeClass('selected');
});

$(document).on('mouseenter','.custom-select-option', function() {
	selectFlag = true;
});

$(document).on('mouseout','.custom-select-option', function() {
	selectFlag = false;
});

// 옵션 클릭 리스너
$(document).on('click','.custom-select-option', function() {
	var value = $(this).attr('value');

	$('.custom-select-text').html($(this).html());
	$('.custom-select-list').slideUp();
	
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
		console.log(response);
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
			str += '<a href="?contentId='+obj.uid+'&command=view&wr_id='+obj.wr_id+'">';
			str += '<div class="cell_thumb">';
			str += '<div class="thumb-wrap" style="background-image: url(\''+obj.wr_path + obj.wr_thumb_sub+'\');">';
			str += '<img src="'+ obj.wr_path + obj.wr_thumb_sub +'" alt="" onerror="this.src=\'/images/no_image.png\'">';
			str += '</div>';
			str += '<span class="vol">Vol.'+obj.wr_vol+'</span>';
			str += '</div>';
			str += '<div class="cell_txt">';
			str += '<div class="cell_cate">'+obj.type+'</div>';
			str += '<div class="cell_subject">'+obj.wr_subject+'</div>';
			str += '<div class="cell_content">'+obj.wr_summary+'</div>';
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
	getComboList();
});

var getComboList = function() {
	$.ajax({
		url : "/web/lastCoverList.do",
		type: "get"
	}).done(function(response){
		if (response.result == "success") {
			setComboList(response.rows)
		}
	}).fail(function(response, status, error){
		alert(response.responseJSON.notice);
	});
}

var setComboList = function (rows) {
	var str = "";
	if (rows.length > 0) {
		$.each(rows, function(i, obj){
			str += '<li data-vol="'+obj.dm_vol+'" value="selectOption'+(i + 1)+'" class="custom-select-option"><strong>Vol.'+(obj.dm_vol.length < 2 ? '0'+obj.dm_vol : obj.dm_vol)+'</strong>'+obj.dm_year + "." + obj.dm_month +'</li>';
		});
	} else {
		str += '<li value="selectOption1" class="custom-select-option">데이터가 없습니다.</li>';
	}
	
	$(".custom-select-list").empty().append(str);
	
	$(".custom-select-list").find("li").eq(0).trigger("click");
}
</script>