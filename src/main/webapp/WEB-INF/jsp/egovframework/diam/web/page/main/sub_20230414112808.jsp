
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 호별선택// -->
<div class="select_total_box">
	<div class="inner">
		<!-- select_con// -->
		<div class="select_con">
			
			
			
			<div class="select_box">
				<select name="year" id="year" class="select">
					<option value="">2024년</option>
				    <option value="">2023년</option>
				</select>
				<span class="ico_arrow"><img src="${layout_path}/images/pages/ico_arrow_sel.png" alt="버튼" /></span>
			</div>
			<div class="select_box">
				<select name="vol" id="vol" class="select">
					<option value="">71호</option>
					<option value="">70호</option>
				    <option value="">69호</option>
				    <option value="">68호</option>
				    <option value="">67호</option>
				</select>
				<span class="ico_arrow"><img src="${layout_path}/images/pages/ico_arrow_sel.png" alt="버튼" /></span>
			</div>
		</div>
		<!-- //select_con -->
		<!-- 전체호_최근발행호// -->
		<div class="total_latest">
			<p class="total_vol">전체 호 <span>200</span></p>
			<p class="latest_vol">최근 발행호 <span>71호</span></p>
		</div>
		<!-- //전체호_최근발행호 -->
	</div>
</div>
<!-- //호별선택 -->

<!-- list// -->
<div class="vol_list">
	<ul>
		<li>
			<a href="?contentId=c2dfd5d61a93c1f65f7beb2ab4d63137a0025f4be49bdd68ec642a8cdaca0801">
				<div class="info">
					<p class="tit"><em>vol. <span class="vol_num">71</span></em><span class="date">2024-04</span></p>
					<p class="logo"><img src="${layout_path}/images/pages/img_logo.png" alt="함께green광주(광주환경공단이 만드는 환경저널)" /></p>
				</div>
				<div class="img">
					<div class="thumb-wrap"><img src="${layout_path}/images/main/img_test3.jpg" alt="" /></div>
				</div>
			</a>
		</li>
		<li>
			<a href="?contentId=c2dfd5d61a93c1f65f7beb2ab4d63137a0025f4be49bdd68ec642a8cdaca0801">
				<div class="info">
					<p class="tit"><em>vol. <span class="vol_num">70</span></em><span class="date">2024-03</span></p>
					<p class="logo"><img src="${layout_path}/images/pages/img_logo.png" alt="함께green광주(광주환경공단이 만드는 환경저널)" /></p>
				</div>
				<div class="img">
					<div class="thumb-wrap"><img src="${layout_path}/images/main/img_test3.jpg" alt="" /></div>
				</div>
			</a>
		</li>
		<li>
			<a href="?contentId=c2dfd5d61a93c1f65f7beb2ab4d63137a0025f4be49bdd68ec642a8cdaca0801">
				<div class="info">
					<p class="tit"><em>vol. <span class="vol_num">69</span></em><span class="date">2024-02</span></p>
					<p class="logo"><img src="${layout_path}/images/pages/img_logo.png" alt="함께green광주(광주환경공단이 만드는 환경저널)" /></p>
				</div>
				<div class="img">
					<div class="thumb-wrap"><img src="${layout_path}/images/main/img_test3.jpg" alt="" /></div>
				</div>
			</a>
		</li>
		<li>
			<a href="?contentId=c2dfd5d61a93c1f65f7beb2ab4d63137a0025f4be49bdd68ec642a8cdaca0801">
				<div class="info">
					<p class="tit"><em>vol. <span class="vol_num">68</span></em><span class="date">2024-01</span></p>
					<p class="logo"><img src="${layout_path}/images/pages/img_logo.png" alt="함께green광주(광주환경공단이 만드는 환경저널)" /></p>
				</div>
				<div class="img">
					<div class="thumb-wrap"><img src="${layout_path}/images/main/img_test3.jpg" alt="" /></div>
				</div>
			</a>
		</li>
		<li>
			<a href="?contentId=c2dfd5d61a93c1f65f7beb2ab4d63137a0025f4be49bdd68ec642a8cdaca0801">
				<div class="info">
					<p class="tit"><em>vol. <span class="vol_num">67</span></em><span class="date">2023-12</span></p>
					<p class="logo"><img src="${layout_path}/images/pages/img_logo.png" alt="함께green광주(광주환경공단이 만드는 환경저널)" /></p>
				</div>
				<div class="img">
					<div class="thumb-wrap"><img src="${layout_path}/images/main/img_test3.jpg" alt="" /></div>
				</div>
			</a>
		</li>
		<li>
			<a href="?contentId=c2dfd5d61a93c1f65f7beb2ab4d63137a0025f4be49bdd68ec642a8cdaca0801">
				<div class="info">
					<p class="tit"><em>vol. <span class="vol_num">66</span></em><span class="date">2023-11</span></p>
					<p class="logo"><img src="${layout_path}/images/pages/img_logo.png" alt="함께green광주(광주환경공단이 만드는 환경저널)" /></p>
				</div>
				<div class="img">
					<div class="thumb-wrap"><img src="${layout_path}/images/main/img_test3.jpg" alt="" /></div>
				</div>
			</a>
		</li>
	</ul>
	<!-- 내용더보기// -->
	<div class="more_con">
		<a href="#"><span class="sr-only">내용 더보기</span></a>
	</div>
	<!-- //내용더보기 -->
</div>
<!-- //list -->



<%-- <!-- 지난호 보기 -->
<div class="area-custom-select">
	<div class="custom-select" tabindex="0">
		<span class="custom-select-text"><strong>Vol.</strong></span>
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

$(document).on('focusin','.custom-select', function() {
	$('.custom-select-list').slideDown();
});

$(document).on('focusout','.custom-select', function() {
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
$(document).on('click','.custom-select-list li', function() {
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
			if (obj.wr_thumb_sub == null) {
				str += '<div class="thumb-wrap" style="background-image: url(\'/images/no_image.png\');">';				
			} else {
				str += '<div class="thumb-wrap" style="background-image: url(\''+obj.wr_path + obj.wr_thumb_sub+'\');">';				
			}
			//str += '<div class="thumb-wrap" style="background-image: url(\''+obj.wr_path + obj.wr_thumb_sub+'\');">';
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
</script> --%>