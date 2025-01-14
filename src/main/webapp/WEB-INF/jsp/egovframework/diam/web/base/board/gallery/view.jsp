<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%@ include file="base.jsp"%>

<link rel="stylesheet" href="<c:url value='${layout_path}/css/content.css' />">

<script>
$(function(){
	$("#modifyWrite").on('click', function(){
		modifyWrite();
	});
	$("#deleteWrite").on('click', function(){
		deleteWrite();
	});
});

function modifyWrite() {
	<c:choose>
		<c:when test="${writeVO.mb_id eq '비회원'}">
			<c:choose>
				<c:when test="${is_admin eq true}">
					executeModify("<c:out value='${param.root}'/>","<c:out value='${writeVO.wr_id}'/>", "<c:out value='${writeSearchQueryString}' escapeXml='false'/>");
				</c:when>
				<c:otherwise>
					passwordPopup("<c:out value='${param.root}'/>","<c:out value='${writeVO.wr_id}'/>", "<c:out value='${pageVO.dm_uid }'/>", "", "<c:out value='${writeSearchQueryString}' escapeXml='false'/>", "modify");
				</c:otherwise>
			</c:choose>
		</c:when>
		<c:otherwise>
			<c:if test="${is_admin eq true || writeVO.mb_id eq DiamLoginVO.id}">
				executeModify("<c:out value='${param.root}'/>","<c:out value='${writeVO.wr_id}'/>", "<c:out value='${writeSearchQueryString}' escapeXml='false'/>");
			</c:if>
		</c:otherwise>
	</c:choose>
}

function deleteWrite() {
	<c:choose>
		<c:when test="${writeVO.mb_id eq '비회원'}">
			<c:choose>
				<c:when test="${is_admin eq true}">
					if (confirm("정말 삭제하시겠습니까?")) {
						executeDelete("<c:out value='${param.root}'/>","<c:out value='${writeVO.wr_id}'/>", "<c:out value='${pageVO.dm_board_id}'/>", "<c:out value='${writeSearchQueryString}' escapeXml='false'/>");
					}					
				</c:when>
				<c:otherwise>
					passwordPopup("<c:out value='${param.root}'/>","<c:out value='${writeVO.wr_id}'/>", "<c:out value='${pageVO.dm_uid }'/>", "<c:out value='${pageVO.dm_board_id}'/>", "<c:out value='${writeSearchQueryString}' escapeXml='false'/>", "delete");
				</c:otherwise>
			</c:choose>	
		</c:when>
		<c:otherwise>
			<c:if test="${is_admin eq true || writeVO.mb_id eq DiamLoginVO.id}">
				if (confirm("정말 삭제하시겠습니까?")) {
					executeDelete("<c:out value='${param.root}'/>","<c:out value='${writeVO.wr_id}'/>", "<c:out value='${pageVO.dm_board_id}'/>", "<c:out value='${writeSearchQueryString}' escapeXml='false'/>");
				}
			</c:if>
		</c:otherwise>
	</c:choose>
} 
</script>

<fmt:parseDate var="wr_datetime" value="${writeVO.wr_datetime}" pattern="yyyy-mm-dd"/>
<div class="bbs bbs_view bbs_<c:out value='${boardVO.dm_skin }'/>" id="bbs_<c:out value='${boardVO.dm_table }'/>">
	<c:if test="${boardVO.dm_use_list_category eq '1' && boardVO.dm_use_category eq '1'}">
		<c:set var="category_array" value="${fn:split(boardVO.dm_category_list ,',') }"/>
		<c:if test="${fn:length(category_array) > 0}">
			<div class="bbs_cate">
				<ul>
					<li class="<c:if test='${empty searchDmWriteVO.search_cate}'>on</c:if>">
						<a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${pageVO.dm_uid}'/>">전체</a>
					</li>
					<c:forEach var="result" items="${category_array}" varStatus="status">
						<c:if test="${result ne null && not empty fn:trim(result)}">
							<li class="<c:if test='${searchDmWriteVO.search_cate eq result}'>on</c:if>">
								<a href="<c:out value='${param.root }'/>/index.do?contentId=<c:out value='${pageVO.dm_uid}'/>&search_cate=<c:out value='${result}'/>">
									<c:out value='${result}'/>
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</div>
		</c:if>
	</c:if>
	<div class="bbs_viewing">
		<c:if test="${!empty writeVO.wr_head }">
			<div class="bbs_view_header" style="background-image: url('${writeVO.wr_path}${writeVO.wr_head}');">
				<img src="<c:out value='${writeVO.wr_path}${writeVO.wr_head}'/>">
			</div>		
		</c:if>
	
		<!-- 타이틀// -->
		<div class="bbs_view_title">
			<h4><c:out value='${fn:replace(writeVO.wr_subject, "&nbsp;", "<br>")}' escapeXml="false"/></h4>
			<p class="sub_txt"><c:out value='${writeVO.wr_sub_subject}' escapeXml="false"/></p>
			<!-- type_pick_wrap// -->
			<div class="type_pick_wrap">
				<span class="type type_2"><c:out value='${boardVO.dm_subject }'/></span>
				<div class="pick_con ">
					<ul>
						<%-- <li class="like"><a href="#"><i></i><span>좋아요</span><strong><c:out value='${writeVO.dm_like}'/></strong></a></li>
						<li class="like2"><a href="#"><i></i><span>공감</span><strong><c:out value='${writeVO.dm_like2}'/></strong></a></li> --%>
						<li class="share top"><a href="javascript:void(0);" class="ico share" title="공유"><i></i><span>공유하기</span></a></li>
					</ul>				
				</div>
				<div class="share_box top">
					<ul>
						<li><a href="javascript:shareSns('facebook');"><img src="${layout_path}/images/pages/facebook.png" alt="">페이스북</a></li>
						<li><a href="javascript:shareSns('blog');"><img src="${layout_path}/images/pages/blog.png" alt="">블로그</a></li>
						<li><a href="javascript:shareSns('twitter');"><img src="${layout_path}/images/pages/twitter.png" alt="">트위터(X)</a></li>
					</ul>
					<div>
						<input type="url" value="" disabled />
						<button type="button" class="share_link" title="링크 복사"><span class="sr-only">링크 복사</span></button>
					</div>
					<button type="button" class="share_close"><span class="sr-only">공유하기 닫기</span></button>
				</div> <!-- //.share_box -->
			</div>
			<!-- //type_pick_wrap -->
		</div>
		<!-- //타이틀 -->
		
		<div class="bbs_view_info">
			<dl class="bbs_view_info_name">
				<dt>작성자</dt>
				<dd>
					<b>
						<c:choose>
							<c:when test='${boardVO.dm_writer_type eq "name"}'>
								 <c:choose>
									<c:when test="${boardVO.dm_writer_secret eq '2' }">
										<c:out value="${fn:substring(writeVO.wr_name, 0, fn:length(writeVO.wr_name) - 1)}"/>*
									</c:when>
									<c:when test="${boardVO.dm_writer_secret eq '3' }">
										<c:out value="${fn:substring(writeVO.wr_name, 0, 1)}"/><c:forEach begin="0" end="${fn:length(writeVO.wr_name) - 2}">*</c:forEach>
									</c:when>
									<c:when test="${boardVO.dm_writer_secret eq '4' }">
										<c:out value="${fn:substring(writeVO.wr_name, 0 , fn:length(writeVO.wr_name) - 2)}"/>**
									</c:when>
									<c:otherwise>
										<c:out value="${writeVO.wr_name}"/>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
									<c:when test="${boardVO.dm_writer_secret eq '2' }">
										<c:out value="${fn:substring(writeVO.mb_id, 0, fn:length(writeVO.mb_id) - 1)}"/>*
									</c:when>
									<c:when test="${boardVO.dm_writer_secret eq '3' }">
										<c:out value="${fn:substring(writeVO.mb_id, 0, 1)}"/><c:forEach begin="0" end="${fn:length(writeVO.mb_id) - 2}">*</c:forEach>
									</c:when>
									<c:when test="${boardVO.dm_writer_secret eq '4' }">
										<c:out value="${fn:substring(writeVO.mb_id, 0 , fn:length(writeVO.mb_id) - 2)}"/>**
									</c:when>
									<c:otherwise>
										<c:out value="${writeVO.mb_id}"/>
									</c:otherwise>
								</c:choose>
							</c:otherwise>
						</c:choose>
					</b>
				</dd>
			</dl>
			<dl class="bbs_view_info_date">
				<dt>작성일</dt>
				<dd><b><fmt:formatDate value="${wr_datetime}" pattern="yyyy-mm-dd"/></b></dd>
			</dl>
			<dl class="bbs_view_info_hit">
				<dt>조회 수</dt>
				<dd><b><c:out value='${writeVO.wr_hit}'/>회</b></dd>
			</dl>
			<c:if test="${boardVO.dm_is_comment eq 1}">
			<dl class="bbs_view_info_cmt">
				<dt>댓글 수</dt>
				<dd><b><c:out value='${writeVO.com_count}'/>개</b></dd>
			</dl>
			</c:if>
		</div>
		
		<c:if test="${boardVO.dm_use_link eq 1}">
			<c:if test="${(writeVO.wr_link1 ne null && not empty writeVO.wr_link1) ||  (writeVO.wr_link2 ne null && not empty writeVO.wr_link2)}">
				<dl class="bbs_view_link">
					<dt>링크</dt>
					<dd>
						<ul>
							<c:if test="${writeVO.wr_link1 ne null && writeVO.wr_link1 ne ''}">
								<li>
									<a href="<c:out value='${writeVO.wr_link1}' escapeXml='false'/>" target="_blank">
										<i class="fa fa-link" aria-hidden="true"></i>
										<c:out value='${writeVO.wr_link1}' escapeXml='false'/>
									</a>
								</li>
							</c:if>
							<c:if test="${writeVO.wr_link2 ne null && writeVO.wr_link2 ne ''}">
								<li>
									<a href="<c:out value='${writeVO.wr_link2}' escapeXml='false'/>" target="_blank">
										<i class="fa fa-link" aria-hidden="true"></i>
										<c:out value='${writeVO.wr_link2}' escapeXml='false'/>
									</a>
								</li>
							</c:if>
						</ul>
					</dd>
				</dl>
			</c:if>
		</c:if>
		
		<c:if test="${boardVO.dm_use_file eq 1}">
			<c:if test='${fn:length(fileList) > 0}'>
				<dl class="bbs_view_file">
					<dt>첨부파일</dt>
					<dd>
						<ul>
							<c:forEach var="result" items="${fileList}" varStatus="status">
								<c:if test="${not empty oriFileList[status.index]}">
									<li>
										<img src="<c:url value='/images/file.png'/>" alt="첨부파일"/>
										<a href="/adm/get_write_file_download.do?file_name=<c:out value='${fileList[status.index]}'/>&ori_file_name=<c:out value='${oriFileList[status.index]}'/>&wr_id=<c:out value='${writeVO.wr_id}'/>&wr_board=<c:out value='${boardVO.dm_id}'/>">
											<c:out value='${oriFileList[status.index]}'/>
										</a>
									</li>
								</c:if>
							</c:forEach>
						</ul>
					</dd>
				</dl>
			</c:if>
		</c:if>
		
		<div class="bbs_view_contents">
			<c:if test="${boardVO.dm_use_file eq 1}">
				<c:if test='${fn:length(fileList) > 0}'>
					<c:set var="ext_arr" value="gif,png,jpeg,jpg,bmp"/>
					<c:forEach var="result2" items="${fileList}" varStatus="status">
						<c:if test="${not empty oriFileList[status.index]}">
							<c:set var="extension" value="${fn:split(result2 ,'.')}"/>
							<c:if test="${fn:contains(ext_arr, fn:toLowerCase(extension[1]))}">
								<img src="<c:out value='${result2}'/>"/>
							</c:if>
						</c:if>
					</c:forEach>
				</c:if>
			</c:if>
			<c:set value="${writeVO.wr_link1}" var="link"/>
			<c:set value="${fn:split(link, '/')}" var="videoId"/>
			<c:forEach items="${videoId }" var="i" varStatus="stat">
				<c:if test="${stat.last}">
					<c:set var="uniqId" value="${i}"/>
				</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${fn:contains(link, 'youtu') }">
					<c:set var="rootSrc" value="https://www.youtube.com/embed/${uniqId}?autoplay=1&mute=1"/>
				</c:when>
				<c:when test="${fn:contains(link, 'vimeo') }">
					<c:set var="rootSrc" value="https://player.vimeo.com/video/${uniqId}?autoplay=1&background=1"/>
				</c:when>
				<c:when test="${fn:contains(link, 'naver') }">
					<c:set var="rootSrc" value="https://tv.naver.com/embed/${uniqId}?autoplay=1"/>
				</c:when>
				<c:when test="${fn:contains(link, 'kakao') }">
					<c:set var="rootSrc" value="https://play-tv.kakao.com/embed/player/cliplink/${uniqId}?service=player_share&amp;autoplay=1"/>
				</c:when>
			</c:choose>
			<c:choose>
			<c:when test="${!empty rootSrc }">
			<style>
			.video-container {
				position: relative;
				padding-bottom: 56.25%;
				height: 0;
				overflow: hidden;
			}
			 
			.video-container iframe,
			.video-container object,
			.video-container embed {
				position: absolute;
				top: 0;
				left: 0;
				width: 100%;
				height: 100%;
			}
			</style>
			<div class="video-container">
				<iframe style="max-width:100%;" src="${rootSrc}" title="<c:out value='${writeVO.wr_subject }' escapeXml='false'/>" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>				
			</div>
			<br>
			<c:out value='${fn:replace(writeVO.wr_content, newLineChar, "<br/>")}' escapeXml="false"/>
			</c:when>
			<c:otherwise>
			<c:out value='${fn:replace(writeVO.wr_content, newLineChar, "")}' escapeXml="false"/>
			</c:otherwise>
			</c:choose>
			
		</div>
		
		<!-- 태그리스트// -->
		<c:if test="${!empty writeVO.wr_hashtag}">
		<div class="bbs_view_tag">
			<ul class="tag_list">
				<c:set value="${fn:split(writeVO.wr_hashtag, '#')}" var="hashtag"/>
				<c:forEach items="${hashtag }" var="tag" varStatus="stat">
				<c:if test="${!empty fn:trim(tag) }">
				<li><a href="#" onclick="unifiedSearch('<c:out value="${fn:trim(tag)}"/>',<c:out value='${CONFIG_INFO.dm_domain_id}'/>);">#<c:out value="${fn:trim(tag)}"/></a></li>
				</c:if>
				</c:forEach>
			</ul>
		</div>
		</c:if>
		<!-- //태그리스트 -->
		
		<ul class="nb_ul">
			<li class="btn_prev">
				<span class="nb_tit"><i class="fa fa-chevron-up" aria-hidden="true"></i> 이전글</span>
				<c:choose>
					<c:when test="${writeVO.prev_id ne null }">
						<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${writeVO.prev_id }' />"><c:out value="${writeVO.prev_subject }" /></a>
					</c:when>
					<c:otherwise>
						<a>이전 게시글이 존재하지 않습니다.</a>
					</c:otherwise>
				</c:choose>
			</li>
			<li class="btn_next">
				<span class="nb_tit"><i class="fa fa-chevron-down" aria-hidden="true"></i> 다음글</span>
				<c:choose>
					<c:when test="${writeVO.next_id ne null }">
						<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${writeVO.next_id }' />"><c:out value="${writeVO.next_subject }" /></a>
					</c:when>
					<c:otherwise>
						<a>다음 게시글이 존재하지 않습니다.</a>
					</c:otherwise>
				</c:choose>
			</li>
		</ul>
		
		<div class="bbs_viewbtn">
			<div class="bbs_viewbtn_1">
				<c:choose>
					<c:when test="${writeVO.mb_id eq '비회원'}">
						<a href="javascript:;" id="modifyWrite" class="btn_write">수정</a>
						<a href="javascript:;" id="deleteWrite" class="btn_delete">삭제</a>
					</c:when>
					<c:otherwise>
						<c:if test="${is_admin eq true || writeVO.mb_id eq DiamLoginVO.id}">
							<a href="javascript:;" id="modifyWrite" class="btn_write">수정</a>
							<a href="javascript:;" id="deleteWrite" class="btn_delete">삭제</a>
						</c:if>
					</c:otherwise>
				</c:choose>
			</div>
			
			<div class="bbs_viewbtn_2">
				<a href="<c:out value='${param.root }'/>/index.do?<c:out value='${writeSearchQueryString}' escapeXml='false'/>" class="btn_list">목록보기 <%-- <img src="${layout_path}/images/arrR_bk.png" alt=""> --%></a>
				<c:if test="${boardVO.dm_is_reply eq 1}">
					<c:if test="${is_reply eq true}">
						<a href="<c:out value='${param.root }'/>/index.do?command=reply&wr_id=<c:out value='${writeVO.wr_id}'/>&<c:out value='${writeSearchQueryString}' escapeXml='false'/>" class="btn_write">답변</a>
					</c:if>
				</c:if>
			</div>
		</div>
		
		<div class="pick_con bot">
			<ul>
				<li class="vol">Vol.<c:out value='${writeVO.wr_vol}'/></li>
				<li class="share bot"><a href="javascript:void(0);" class="ico share" title="공유"><i></i><span>공유하기</span></a></li>
			</ul>				
			<div class="share_box bot">
				<ul>
					<li><a href="javascript:shareSns('facebook');"><img src="${layout_path}/images/pages/facebook.png" alt="">페이스북</a></li>
					<li><a href="javascript:shareSns('blog');"><img src="${layout_path}/images/pages/blog.png" alt="">블로그</a></li>
					<li><a href="javascript:shareSns('twitter');"><img src="${layout_path}/images/pages/twitter.png" alt="">트위터(X)</a></li>
				</ul>
				<div>
					<input type="url" value="" disabled />
					<button type="button" class="share_link" title="링크 복사"><span class="sr-only">링크 복사</span></button>
				</div>
				<button type="button" class="share_close"><span class="sr-only">공유하기 닫기</span></button>
			</div> <!-- //.share_box -->
		</div>
		
		<div class="bbs_view_writer">
			<ul>
				<c:if test="${not empty writeVO.wr_writer}">
				<li class="writer">
					<span>에디터</span>
					<strong><c:out value='${writeVO.wr_writer}' escapeXml="false"/></strong>
					<span><c:out value='${writeVO.wr_writer_mail}' escapeXml="false"/></span>
				</li>
				</c:if>
				<c:if test="${not empty writeVO.wr_pictured}">
				<li class="picture">
					<span>사진</span>
					<strong><c:out value='${writeVO.wr_pictured}' escapeXml="false"/></strong>
				</li>
				</c:if>
				<li class="date">
					<fmt:formatDate value="${wr_datetime}" pattern="yyyy.mm.dd"/>
				</li>
			</ul>
		</div>
		
		<div class="bbs_view_slide">
			<h6>같이 보면 좋은 콘텐츠</h6>
			<div class="vol-slider">
				<div class="swiper-container">
					<ul class="swiper-wrapper">
					</ul>
				</div>
				<div class="swiper-button-next"></div>
				<div class="swiper-button-prev"></div>
			</div>
		</div>
		
	</div>
	<c:if test="${boardVO.dm_is_comment eq 1}">
		<c:if test="${writeVO.wr_reply eq '0'}">
			<c:import url="/write/get_comment_list.do?dm_id=${pageVO.dm_board_id}"/>
		</c:if>	
	</c:if>
</div>

<script>
	$(function() {
		var currentURL = window.location.href;
		$('.share_box.top input[type="url"]').val(currentURL);
		$('.share_box.top .share_link').on('click', function(){
			$('.share_box.top input[type="url"]').attr('disabled', false);
			$('.share_box.top input[type="url"]').select();
			var copyURL = document.execCommand('copy');
			if (copyURL) {
				alert('링크가 복사되었습니다.');
			}
			$('.share_box.top input[type="url"]').attr('disabled', true);
		});
	
		$('.share.top .share').on('click', function(){
			$('.share_box.top').toggle();
		});
		$('.share_box.top .share_close').on('click', function(){
			$('.share_box.top').toggle();
		});
	});
</script>

<script>
	$(function() {
		var currentURL = window.location.href;
		$('.share_box.bot input[type="url"]').val(currentURL);
		$('.share_box.bot .share_link').on('click', function(){
			$('.share_box.bot input[type="url"]').attr('disabled', false);
			$('.share_box.bot input[type="url"]').select();
			var copyURL = document.execCommand('copy');
			if (copyURL) {
				alert('링크가 복사되었습니다.');
			}
			$('.share_box.bot input[type="url"]').attr('disabled', true);
		});
	
		$('.share.bot .share').on('click', function(){
			$('.share_box.bot').toggle();
		});
		$('.share_box.bot .share_close').on('click', function(){
			$('.share_box.bot').toggle();
		});
	});
</script>

<script>
//해당 호수 콘텐츠 슬라이드
var volSwiper = new Swiper(".vol-slider .swiper-container", {
	slidesPerView: 2,
	spaceBetween: 15,
	observer: true,
	observeParents: true,
	autoplay: {
		delay: 3500,
		disableOnInteraction: false,
	},
	navigation: {
		nextEl: ".vol-slider .swiper-button-next",
		prevEl: ".vol-slider .swiper-button-prev",
	},
	breakpoints: {
		576: {
			slidesPerView: 3,
			spaceBetween: 30,
		},
	}
});

$(function(){
	var vol = "<c:out value='${writeVO.wr_vol}'/>";
	var pk = "<c:out value='${writeVO.wr_id}'/>";
	
	$.ajax({
		url: "/web/selectSameVolWrite.do",
		data: {
			wr_id: pk,
			wr_vol: vol
		},
		type: "get"
	}).done(function(response){
		if (response.result == "success") {
			setList(response.rows);
		} else {
			alert(response.notice);
		}
	}).fail(function(request, status, error){
		alert(request.responseJSON.notice);
	});
});


function setList(rows) {
	var target = $(".swiper-wrapper");
	
	var str = "";
	if (rows.length > 0) {
		$.each(rows, function(i, obj) {
			
			str += '<li class="swiper-slide">';
			str += '<a href="?command=view&wr_id='+obj.wr_id+'&contentId='+obj.uid+'">';
			str += '<div class="cell_thumb">';
			if (obj.wr_thumb_sub == null) {
				str += '<div class="thumb-wrap" style="background-image: url(\'/images/no_image.png\');">';				
			} else {
				str += '<div class="thumb-wrap" style="background-image: url(\''+obj.wr_path + obj.wr_thumb_sub+'\');">';				
			}
			str += '<img src="'+obj.wr_path + obj.wr_thumb_sub+'" alt="" onerror="this.src=\'/images/no_image.png\'">';
			str += '</div>';
			str += '<div class="cell_txt">';
			str += '<p class="type type_1">'+obj.type+'</p>';
			str += '<p class="cell_subject">'+obj.wr_subject+'</p>';
			str += '</div>';
			str += '</a>';
			str += '</li>';
		});
	} else {
		str += '<li style="max-width: 100%; flex: 100%;"><img style="max-width:100%;" src="/images/noimg_content.jpg" alt="콘텐츠가 없습니다."></li>';
	}
	target.empty();
	target.append(str);
	
}
</script>