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
		<h5><c:if test="${!empty writeVO.ca_name }"><span class="cate theme-color-1">[<c:out value="${writeVO.ca_name}"/>] </span></c:if><c:out value='${writeVO.wr_subject}' escapeXml="false"/></h5>
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
			<c:out value='${fn:replace(writeVO.wr_content, newLineChar, "<br/>")}' escapeXml="false"/>
		</div>
		
		<div class="bbs_viewbtn">
			<div class="bbs_viewbtn_1">
				<c:choose>
					<c:when test="${writeVO.mb_id eq '비회원'}">
						<a href="javascript:;" data-toggle="modal" data-target="#commentModal2" class="btn_write sub2">수정</a>
						<a href="javascript:;" data-toggle="modal" data-target="#commentModal2" class="btn_delete sub2">삭제</a>
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
				<a href="<c:out value='${param.root }'/>/index.do?<c:out value='${writeSearchQueryString}' escapeXml='false'/>" class="btn_write">목록</a>
				<c:if test="${boardVO.dm_is_reply eq 1}">
					<c:if test="${is_reply eq true}">
						<a href="<c:out value='${param.root }'/>/index.do?command=reply&wr_id=<c:out value='${writeVO.wr_id}'/>&<c:out value='${writeSearchQueryString}' escapeXml='false'/>" class="btn_write">답변</a>
					</c:if>
				</c:if>
			</div>
		</div>
		
		<ul class="nb_ul">
			<c:if test="${!empty prevWriteVO }">
			<li class="btn_prev">
				<span class="nb_tit"><i class="fa fa-chevron-up" aria-hidden="true"></i> 이전글</span>
				<c:choose>
					<c:when test="${prevWriteVO.wr_option eq 'secret' }">
						<c:choose>
						<c:when test="${prevWriteVO.mb_id eq '비회원'}">
							<c:choose>
							<c:when test="${is_admin}">
							<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${prevWriteVO.wr_id }' />"><c:out value="${prevWriteVO.wr_subject }" /></a>
							</c:when>
							<c:otherwise>
							<a href="javascript:secretCheck('<c:out value='${param.root }'/>/index.do?command=view&wr_id=<c:out value="${prevWriteVO.wr_id}"/>&<c:out value="${writeSearchQueryString}" escapeXml='false'/>', true , '<c:out value='${prevWriteVO.wr_id}'/>', '<c:out value='${pageVO.dm_uid }'/>', '<c:out value="${writeSearchQueryString}" escapeXml="false"/>');">비밀글입니다.</a>
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${is_admin ne true && prevWriteVO.mb_id ne DiamLoginVO.id}">
									<a href="javascript:alert('작성자와 관리자만 접근 가능합니다.');">비밀글입니다.</a>
								</c:when>
								<c:otherwise>
								<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${prevWriteVO.wr_id }' />"><c:out value="${prevWriteVO.wr_subject }" /></a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${prevWriteVO.wr_id }' />"><c:out value="${prevWriteVO.wr_subject }" /></a>
					</c:otherwise>
				</c:choose>
			</li>
			</c:if>
			<c:if test="${!empty nextWriteVO }">
			<li class="btn_next">
				<span class="nb_tit"><i class="fa fa-chevron-down" aria-hidden="true"></i> 다음글</span>
				<c:choose>
					<c:when test="${nextWriteVO.wr_option eq 'secret' }">
						<c:choose>
						<c:when test="${nextWriteVO.mb_id eq '비회원'}">
							<c:choose>
							<c:when test="${is_admin}">
							<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${nextWriteVO.wr_id }' />"><c:out value="${nextWriteVO.wr_subject }" /></a>
							</c:when>
							<c:otherwise>
							<a href="javascript:secretCheck('<c:out value='${param.root }'/>/index.do?command=view&wr_id=<c:out value="${nextWriteVO.wr_id}"/>&<c:out value="${writeSearchQueryString}" escapeXml='false'/>', true , '<c:out value='${nextWriteVO.wr_id}'/>', '<c:out value='${pageVO.dm_uid }'/>', '<c:out value="${writeSearchQueryString}" escapeXml="false"/>');">비밀글입니다.</a>
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${is_admin ne true && nextWriteVO.mb_id ne DiamLoginVO.id}">
									<a href="javascript:alert('작성자와 관리자만 접근 가능합니다.');">비밀글입니다.</a>
								</c:when>
								<c:otherwise>
								<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${nextWriteVO.wr_id }' />"><c:out value="${nextWriteVO.wr_subject }" /></a>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<a href="<c:out value='${param.root }'/>/index.do?command=view&contentId=<c:out value='${pageVO.dm_uid}'/>&wr_id=<c:out value='${nextWriteVO.wr_id }' />"><c:out value="${nextWriteVO.wr_subject }" /></a>
					</c:otherwise>
				</c:choose>
			</li>
			</c:if>
		</ul>
	</div>
	<!-- 개인정보수집동의 -->
	<div class="bbs_agree_docs">
		<h4>개인정보 수집 동의 <span class="point">[필수]</span></h4>
		<div class="bbs_agree_text">
			<p class="text">광주환경공단은 환경소식지 퀴즈 신청 및 처리를 위해 최소한의 개인정보를 아래와 같이 수집&middot;이용하고 있습니다.</p>
			<ul class="list_style">
				<li>수집 목적 : 환경소식지 퀴즈 접수 및 처리</li>
				<li>수집 항목 : 이름, 비밀번호, 연락처</li>
				<li>보유 이용기간 : <strong class="point">이벤트 퀴즈 종료 시</strong></li>
			</ul>
			<p class="text">※ 정보주체께서는 개인정보 수집&middot;이용 동의를 거부할 권리가 있으며, 동의를 거부할 경우에는 환경소식지 의견게시 퀴즈 참여에 제한을 받게 됩니다.</p>
		</div>
		<div class="agree_check_box">
			<p>☞ 개인정보 수집•이용에 동의하시겠습니까?</p>
			<div class="agree_radio">
				<span>
					<input type="radio" id="agreeYN1" name="agreeYN" value="y" />
					<label for="agreeYN1">동의</label>
				</span>
				<span>
					<input type="radio" id="agreeYN2" name="agreeYN" value="n" />
					<label for="agreeYN2">동의하지 않음</label>
				</span>
			</div>
			<p>(동 서비스는 만14세 이상에게 제공합니다. 필요한 경우에는 법정대리인을 통해 신청해 주시기 바랍니다.)</p>
		</div>
	</div>
	<!-- 개인정보수집동의 -->
	<c:if test="${boardVO.dm_is_comment eq 1}">
		<c:if test="${writeVO.wr_reply eq '0'}">
			<c:import url="/write/get_comment_list.do?dm_id=${pageVO.dm_board_id}"/>
		</c:if>	
	</c:if>
</div>

<!-- Modal -->
<div class="modal fade modal-style" id="commentModal2" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title sr-only" id="commentModal2Label">비밀번호 입력</h5>
				<p class="notice">게시글 삭제 및 수정은 작성자·관리자만 가능합니다.</p>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="18" height="18" viewBox="0 0 18 18">
						<defs>
							<clipPath id="clip-path"><rect width="18" height="18" fill="#fff" stroke="#333" stroke-width="1"/></clipPath>
						</defs>
						<g clip-path="url(#clip-path)">
							<g transform="translate(9.143 -5) rotate(45)">
								<path d="M20,1H0A1,1,0,0,1-1,0,1,1,0,0,1,0-1H20a1,1,0,0,1,1,1A1,1,0,0,1,20,1Z" transform="translate(0 10)" fill="#333"/>
								<path d="M20,1H0A1,1,0,0,1-1,0,1,1,0,0,1,0-1H20a1,1,0,0,1,1,1A1,1,0,0,1,20,1Z" transform="translate(10) rotate(90)" fill="#333"/>
							</g>
						</g>
					</svg>
				</button>
			</div>
			<div class="modal-body">
				<table class="modify_table">
					<tbody>
						<tr class="anonymous-only2">
							<th><label for="">비밀번호</label></th>
							<td>
								<form method="post" id="frm" onsubmit="return false;">
									<input type="hidden" id="aRSAModulus" value="${RSAModulus}"/>
									<input type="hidden" id="aRSAExponent" value="${RSAExponent}"/>
									<input type="password" class="form-control" id="pwd2" placeholder="비밀번호를 입력해주세요." />
									<input type="hidden" name="wr_id" id="pk">
									<input type="hidden" name="board_id" id="boardPk">
									<input type="hidden" name="paramMap" id="param">
								</form>
								<p class="noty">※게시글 작성 시 기재했던 비밀번호를 입력해 주세요</p>
							</td>
						</tr>
						<tr class="delete-only2">
							<th style="text-align:center;">삭제하시겠습니까?</th>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="modal-footer2">
				<button type="button" class="btn btn-sm btn-fill-03">확인</button>
				<button type="button" class="btn btn-sm btn-line btn-line-03" data-dismiss="modal">취소</button>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).on("click", ".sub2" , function(){
		$(".delete-only2").hide();
		$(".modal-footer2 button").eq(0).removeClass("auth2");
		$(".modal-footer2 button").eq(0).removeClass("d_confirm2");
		$(".modal-footer2 button").eq(0).addClass("auth2");
		
		if ($(this).text() == "수정") {
			$(".modal-footer2 button").eq(0).attr("id", "mod");
		} else {
			$(".modal-footer2 button").eq(0).attr("id", "del");			
		}
	});
	
	$(document).on("click", ".auth2", function(){
		var flag = $(this).attr("id");
		
		var input = $("#pwd2").val();
		
		if (input != "") {
			var rsa = new RSAKey();
			rsa.setPublic($('#aRSAModulus').val(),$('#aRSAExponent').val());
			$("#pwd2").val(rsa.encrypt(input));
		}
		
		$.ajax({
			url: "/write/check_password.do",
			type:"post",
			data: {
				contentId: "<c:out value='${param.contentId}'/>",
				chkpass: $("#pwd2").val(),
				wr_id: "<c:out value='${param.wr_id}'/>"
			},success: function(response){
				if (response.result == "success") {
					if (flag == "del") {
						$(".anonymous-only2").hide();
						$(".delete-only2").show();
						$(".auth2").addClass("d_confirm2");
					} else {
						alert("인증되었습니다.");
						$(".modal-footer2 button").eq(1).trigger("click");
						location.href = "/index.do?command=modify&wr_id=<c:out value='${writeVO.wr_id}' />&"+unescapeHtml("<c:out value='${writeSearchQueryString}' escapeXml='false'/>");
					}
					
					$(".auth2").removeClass("auth2");
				} else {
					alert(response.notice);
				}
				$("#pwd2").val("");
			},error: function(request, status, error) {
				$("#pwd2").val("");
				alert(request.responseJSON.notice);
			}
		});
	});
	
	$("#commentModal2").on("hidden.bs.modal", function(){
		$(".modal-footer2 button").eq(0).attr("id", "");
		$("#pwd2").val("");
		$(".anonymous-only2").show();
		$(".delete-only2").hide();
	});
	
	$(document).on("click", ".d_confirm2", function(){
		location.href = "/write/delete_write.do?wr_id=<c:out value='${writeVO.wr_id}' />&board_id=<c:out value='${writeVO.wr_board}' />&"+unescapeHtml("<c:out value='${writeSearchQueryString}' escapeXml='false'/>");
	});
	
</script>
