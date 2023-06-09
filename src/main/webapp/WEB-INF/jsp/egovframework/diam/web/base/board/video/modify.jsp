<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="base.jsp"%>
<script type="text/javascript" src="/js/egovframework/diam/rsa/rsa.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/jsbn.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/prng4.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/rng.js"></script>
<script>
var oEditors = [];
$(function () {
	
	<c:if test="${boardVO.dm_use_dhtml_editor eq 1}">
	nhn.husky.EZCreator.createInIFrame({
		oAppRef : oEditors, 
		elPlaceHolder : "wr_content", //저는 textarea의 id와 똑같이 적어줬습니다.
		sSkinURI : "/js/egovframework/diam/se2/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
		fCreator : "createSEditor2",
		htParams : { // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true 
		}
	});
	</c:if>
	
	$('.filebox .upload-hidden').on('change', function(){// 값이 변경되면
		if(window.FileReader){ // modern browser
		    var filename = $(this)[0].files[0].name;
		} else { // old IE
		    var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
		}

		// 추출한 파일명 삽입
		$(this).siblings('.upload-name').val(filename);
	});
	
	$("#btn_write").on('click', function(){
		$("#writeVO").submit();
		$("#wr_password").val("");
	});
});
	
function checkForm() {
	<c:if test="${boardVO.dm_use_dhtml_editor eq 1}">
	oEditors.getById["wr_content"].exec("UPDATE_CONTENTS_FIELD", []); //textarea의 id를 적어줍니다.
	</c:if>
	
	<c:if test="${writeVO.mb_id eq '비회원'}">
		var wr_password = $("#wr_password").val();
		if (wr_password != "" && wr_password != null) {
			var rsa = new RSAKey();
			rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
			$("#wr_password").val(rsa.encrypt(wr_password));
		}
	</c:if>
	
	var link = $("#wr_link1").val();
	if (link == "") {
		alert("정확한 동영상 공유 링크를 입력해주세요");
		return false;
	}
	
	if ($("#wr_vol").val() == "") {
		alert("발행 호수를 입력하세요.");
		$("#wr_vol").focus();
		return false;
	}
	
	var banner = $("#banner")[0].files[0];
	if (banner != null) {
		if (banner.size > 52428800) {
			alert("파일 사이즈는 50MB를 초과할 수 없습니다.");
			return false;
		}
	}
}

$(document).on("click", ".rmv", function(e){
	e.preventDefault();
	$(this).closest("div").remove();
});
</script>
<p aria-hidden="true" class="mb15"><span class="required">*</span>표시된 입력값은 필수입력값입니다.</p>
<div class="bbs bbs_post bbs_<c:out value='${boardVO.dm_skin }'/>" id="bbs_<c:out value='${boardVO.dm_table }'/>">
	<form action="<c:out value='${param.root }'/>/write/set_write.do" name="writeVO" id="writeVO" method="post" enctype="multipart/form-data" onsubmit="return checkForm();">
		<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
		<input type="hidden" id="RSAExponent" value="${RSAExponent}"/> 
		<input type="hidden" name="dm_table" value="<c:out value='${boardVO.dm_table}'/>"/>
		<input type="hidden" name="wr_id" value="${writeVO.wr_id}"/>
		<input type="hidden" name="type" value="update"/>
		<input type="hidden" name="wr_board" id="wr_board" value="${boardVO.dm_id}"/>
		<input type="hidden" name="board_id" id="board_id" value="${boardVO.dm_id}"/>
		<input type="hidden" name="dm_id" id="dm_id" value="${boardVO.dm_id}"/>
		<input type="hidden" name="writeQueryString" value="<c:out value='${writeSearchQueryString}' escapeXml='false'/>"/>
		<table class="table-form">
			<caption><c:out value='${boardVO.dm_subject}'/>게시글 등록 테이블 입니다.</caption>
			<colgroup>
	            <col style="width:15%" />
	            <col />
	        </colgroup>
	        <tbody>
	        	<c:if test="${is_admin || boardVO.dm_use_secret eq '1'}">
	        		<tr>
	        			<th>옵션</th>
	        			<td>
		        			<div class="option">
								<c:if test="${is_admin && writeVO.wr_reply eq 0}">
		        					<div class="custom-control custom-checkbox mr-3">
										<input type="checkbox" name="wr_is_notice" value="1" id="notice" class="custom-control-input" 
										<c:if test="${writeVO.wr_is_notice eq '1' }">checked</c:if> >
										<label class="custom-control-label" for="notice"><em></em>공지</label>
									</div>
								</c:if>
		        			</div>
						</td>
	        		</tr>
	        	</c:if>
	        	
	        	<c:if test="${boardVO.dm_use_category eq 1}">
	        		<tr>
	        			<th><label for="ca_name">분류</label></th>
	        			<td>
	        				<select name="ca_name" id="ca_name" class="custom-select">
	        					<option value="">선택안함</option>
	        					<c:set var="dm_category_arr" value="${fn:split(boardVO.dm_category_list,',')}"/>
	        					<c:forEach var="result" items="${dm_category_arr}" varStatus="status">
									<c:if test="${result ne null && not empty fn:trim(result)}">
										<option value="${result}" <c:if test='${searchDmWriteVO.search_cate eq result}'>selected="selected"</c:if>><c:out value="${result}"/></option>
									</c:if>
								</c:forEach>
	        				</select>
	        			</td>
	        		</tr>
	        	</c:if>
				<tr>
					<th><label for="wr_subject">제목 <span class="required">필수</span></label></th>
					<td><input type="text" name="wr_subject" id="wr_subject" class="form-control" value="${writeVO.wr_subject }"/></td>
				</tr>
				
				<c:choose>
					<c:when test="${DiamLoginVO.id eq null}">
						<tr>
							<th><label for="wr_name">작성자<span class="required">*</span></label></th>
							<td>
								<input type="text" name="wr_name" id="wr_name" class="form-control" value="${writeVO.wr_name }"/>
							</td>
						</tr>
					</c:when>
					<c:otherwise>					
						<input type="hidden" name="wr_name" id="wr_name" value="${DiamLoginVO.name}"/>
					</c:otherwise>
				</c:choose>
				<tr>
					<th><label for="wr_link1">유튜브 공유 링크 <span class="required">필수</span></label></th>
					<td><input type="text" name="wr_link1" id="wr_link1" class="form-control" value="${writeVO.wr_link1}"/>
						<p>★정확한 유튜브 공유 URL을 입력해야 player와 썸네일이 정상 출력 됩니다.</p>
					</td>
				</tr>
				<c:if test='${DiamLoginVO.id eq null}'>
					<tr class="write_password">
						<th><label for="wr_password">비밀번호<span class="required">*</span></label></th>
						<td>
							<input type="password" name="wr_password" id="wr_password" class="form-control" autocomplete="new-password"/>
						</td>
					</tr>
				</c:if>
				<tr>
					<th><label for="wr_vol">발행호<span class="required">*</span></label></th>
					<td>
						<input type="text" name="wr_vol" id="wr_vol" value="<c:out value='${writeVO.wr_vol }'/>" class="form-control" autocomplete="off" placeholder="발행호수"/>
					</td>
				</tr>
				<tr>
					<th><label for="wr_main">메인게시글<span class="required">*</span></label></th>
					<td>
						<label><input type="radio" name="wr_main" id="wr_main" value="N" <c:if test="${writeVO.wr_main eq 'N'}">checked</c:if>/> 미사용</label>
						<label><input type="radio" name="wr_main" id="wr_main" value="Y" <c:if test="${writeVO.wr_main eq 'Y'}">checked</c:if>/> 사용</label>
					</td>
				</tr>
				<tr>
					<th><label for="wr_direct">바로가기 링크</label></th>
					<td>
						<input type="text" name="wr_direct" id="wr_direct" class="form-control" autocomplete="off" placeholder="바로가기 링크"/>
					</td>
				</tr>
				<tr>
					<th><label for="head">타이틀 이미지</label></th>
					<td>
						<div class="filebox">
							<input class="upload-name" value="파일선택" disabled="disabled"/>
							<label for="head">업로드</label>
							<input type="file" name="head" id="head" class="upload-hidden" accept="image/*"/>
						</div>
						<c:if test="${!empty writeVO.wr_head }">
							<div class="fileout">
								<c:set value="${fn:length(writeVO.wr_head) }" var="lenHead"/>
								<span class="fileout_checkbox"><a href="#" class="rmv">삭제</a></span>
								<span class="fileout_filename"><a href="<c:out value='${writeVO.wr_path}${writeVO.wr_head}' />" target="_blank"><c:out value='${fn:substring(writeVO.wr_head, 15, lenHead)}'/></a></span>
								<input type="hidden" name="wr_head" value="<c:out value='${writeVO.wr_head }'/>">
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th><label for="banner">영상배너</label></th>
					<td>
						<div class="filebox">
							<input class="upload-name" value="파일선택" disabled="disabled"/>
							<label for="banner">업로드</label>
							<input type="file" name="banner" id="banner" class="upload-hidden" accept="video/*"/>
						</div>
						<c:if test="${!empty writeVO.wr_banner }">
							<div class="fileout">
								<c:set value="${fn:length(writeVO.wr_banner) }" var="lenBanner"/>
								<span class="fileout_checkbox"><a href="#" class="rmv">삭제</a></span>
								<span class="fileout_filename"><a href="<c:out value='${writeVO.wr_path}${writeVO.wr_banner}' />" target="_blank"><c:out value='${fn:substring(writeVO.wr_banner, 15, lenBanner)}'/></a></span>
								<input type="hidden" name="wr_banner" value="<c:out value='${writeVO.wr_banner }'/>">
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th><label for="background">배너 포스터</label></th>
					<td>
						<div class="filebox">
							<input class="upload-name" value="파일선택" disabled="disabled"/>
							<label for="background">업로드</label>
							<input type="file" name="background" id="background" class="upload-hidden" accept="image/*"/>
						</div>
						<c:if test="${!empty writeVO.wr_background }">
							<div class="fileout">
								<c:set value="${fn:length(writeVO.wr_background) }" var="lenBack"/>
								<span class="fileout_checkbox"><a href="#" class="rmv">삭제</a></span>
								<span class="fileout_filename"><a href="<c:out value='${writeVO.wr_path}${writeVO.wr_background}' />" target="_blank"><c:out value='${fn:substring(writeVO.wr_background, 15, lenBack)}'/></a></span>
								<input type="hidden" name="wr_background" value="<c:out value='${writeVO.wr_background }'/>">
							</div>
						</c:if>
					</td>
				</tr>
				<tr>
					<th><label for="wr_content">내용<span class="required">*</span></label></th>
					<td>
						<c:choose>
							<c:when test="${boardVO.dm_use_dhtml_editor eq 1}">
								<textarea id="wr_content" name="wr_content" rows="5" style="width:100%">
									<c:out value="${dm_basic_content_editor}"/>
									<c:out value="${writeVO.wr_content }"></c:out>
								</textarea>
							</c:when>
							<c:otherwise>
								<textarea id="wr_content" name="wr_content" rows="5" style="width:100%"><c:out value="${dm_basic_content_normal}" escapeXml="false"/><c:out value="${writeVO.wr_content }" escapeXml="false"/></textarea>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				
				<c:if test="${boardVO.dm_use_link eq 1 && is_link eq true}">
				<!-- 영상 게시판 링크1 번은 유튜브 링크로 사용 , 추가 1개만 더 등록 가능으로 수정 -->
					<tr>
						<th>
							<label for="wr_link2">
								<i class="fa fa-link fa-fw" aria-hidden="true"></i> 링크 
							</label>
						</th>
						<td>
							<input type="text" name="wr_link2" id="wr_link2" class="form-control" size="50" value="<c:out value='${writeVO.wr_link2 }' />" />
						</td>
					</tr>
				</c:if>
				
				<c:if test="${boardVO.dm_use_file eq 1 && is_file eq true}">
					<c:if test='${boardVO.dm_upload_count > 0 }'>
					<c:set var="dm_file_arr" value="${fn:split(writeVO.wr_ori_file_name,'|')}"/>
						<%-- <c:forEach var="result" items="${dm_file_arr }" varStatus="status"> --%>
						<%-- <c:forEach var="result" begin="0" end="${boardVO.dm_upload_count - 1}" items="${dm_file_arr }" varStatus="status"> --%>
						<c:forEach var="result" begin="0" end="${boardVO.dm_upload_count - 1}" varStatus="status">
							<tr>
								<th>첨부파일<c:out value='${status.index + 1}'/></th>
								<td>
									<div class="filebox">
										<input class="upload-name" value="파일선택" disabled="disabled"/>
										<label for="file${status.index}">업로드</label>
										<input type="file" name="file" id="file${status.index}" class="upload-hidden"/>
									</div>
									<div class="fileout">
										<span class="fileout_checkbox"><label>삭제 <input type="checkbox" name="del_file_${status.index}" value="1" /></label></span>
										<span class="fileout_filename"><a href="${dm_file_arr[status.index]}" target="_blank"><c:out value='${dm_file_arr[status.index]}'/></a></span>
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</c:if>
	        </tbody>
		</table>
		<div class="bbs_captcha">
		
		</div>
		<div class="bbs_postbtn">
			<a href="<c:out value='${param.root }'/>/index.do?<c:out value='${writeSearchQueryString}'/>" class="btn_cancel">취소</a>
			<button type="button" id="btn_write" class="btn_submit">수정</button>
		</div>
	</form>
</div>