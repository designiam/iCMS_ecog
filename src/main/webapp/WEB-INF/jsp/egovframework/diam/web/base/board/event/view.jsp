<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%@ include file="base.jsp"%>
<script type="text/javascript" src="/js/egovframework/diam/rsa/rsa.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/jsbn.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/prng4.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/rng.js"></script>
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
			<c:if test="${!empty writeVO.ca_name }"><span class="cate"><c:out value='${writeVO.ca_name }'/></span></c:if>
			<h4><c:out value='${fn:replace(writeVO.wr_subject, "&nbsp;", "<br>")}' escapeXml="false"/></h4>
			<p class="sub_txt"><c:out value='${writeVO.wr_sub_subject}' escapeXml="false"/></p>
			
			<div class="info">
			<c:if test="${!empty writeVO.wr_start_dt && !empty writeVO.wr_end_dt }">
			<dl>
				<dt>응모기간</dt>
				<dd id="period"><c:out value="${writeVO.wr_start_dt}"/> ~ <c:out value="${writeVO.wr_end_dt}"/></dd>
			</dl>
			</c:if>
			<c:if test="${!empty writeVO.wr_announce }">
			<dl>
				<dt>결과발표</dt>
				<dd id="announce"><c:out value="${writeVO.wr_announce}"/></dd>
			</dl>
			</c:if>
			<c:if test="${!empty writeVO.wr_target }">
			<dl>
				<dt>참여대상</dt>
				<dd id="target"><c:out value="${writeVO.wr_target }" /></dd>
			</dl>
			</c:if>
			<c:if test="${!empty writeVO.wr_host }">
			<dl>
				<dt>주최</dt>
				<dd id="host"><c:out value="${writeVO.wr_host }" /></dd>
			</dl>
			</c:if>
			<c:if test="${!empty writeVO.wr_inquiry }">
			<dl>
				<dt>문의처</dt>
				<dd id="inquiry"><c:out value="${writeVO.wr_inquiry }" /></dd>
			</dl>
			</c:if>
		</div>
		
			<div class="pick_con">
				<ul>
					<li class="share"><a href="javascript:void(0);" class="ico share" title="공유"><i></i><span>공유하기</span></a></li>
				</ul>				
				<div class="share_box">
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
		</div>
		<!-- //타이틀 -->

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
			<c:out value='${fn:replace(writeVO.wr_content, newLineChar, "<br/>")}' escapeXml="false"/>
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
		
		<ul class="nb_ul" style="display:none">
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
				<li class="share"><a href="javascript:void(0);" class="ico share" title="공유"><i></i><span>공유하기</span></a></li>
			</ul>				
			<div class="share_box">
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
				<c:if test="${not empty writeVO.wr_name}">
				<li class="writer">
					<span>에디터</span>
					<strong>
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
					</strong>
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
	$('.share_box input[type="url"]').val(currentURL);
	$('.share_box .share_link').on('click', function() {
		$('.share_box input[type="url"]').attr('disabled', false);
		$('.share_box input[type="url"]').select();
		var copyURL = document.execCommand('copy');
		if (copyURL) {
			alert('링크가 복사되었습니다.');
		}
		$('.share_box input[type="url"]').attr('disabled', true);
	});

	$('.share .share').on('click', function(){
		$('.share_box').toggle();
	});
	$('.share_box .share_close').on('click', function(){
		$('.share_box').toggle();
	});
});
</script>
