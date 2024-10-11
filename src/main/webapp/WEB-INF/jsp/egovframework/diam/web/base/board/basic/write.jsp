<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
		return checkForm();
	});
});

function checkForm() {
	//개인정보수입이용동의 체크 확인
	var agreeYN = $('input[name="agreeYN"]:checked').val();
	if (agreeYN != "y") {
		alert("개인정보 수집•이용 동의 후 이용가능합니다.");
		$('#agreeYN1').focus();
		return false;
	}
	
	var wr_subject = $('input[name="wr_subject"]').val();
	if (wr_subject == "") {
		alert("제목을 입력해 주세요.");
		$('#wr_subject').focus();
		return false;
	}
	
	var wr_name = $('input[name="wr_name"]').val();
	if (wr_name == "") {
		alert("작성자를 입력해 주세요.");
		$('#wr_name').focus();
		return false;
	}
	
	<c:if test="${boardVO.dm_use_dhtml_editor eq 1}">
	oEditors.getById["wr_content"].exec("UPDATE_CONTENTS_FIELD", []); //textarea의 id를 적어줍니다.
	</c:if>
		
	<c:if test="${DiamLoginVO.id eq null}">
		var wr_password = $("#wr_password").val();
    	if (wr_password != "" && wr_password != null) {
    		var rsa = new RSAKey();
    		rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
    		$("#wr_password").val(rsa.encrypt(wr_password));
    	} else {
    		alert("비회원으로 등록 시에는 비밀번호를 입력해주세요.");
    		return false;
    	}
	</c:if>
	
	var wr_content = $('#wr_content').val().replace(/(<([^>]+)>)/ig,"").replace(/&nbsp;/g, "");
	if (wr_content == "") {
		alert("내용을 입력해 주세요.");
		$('#wr_content').focus();
		return false;
	}

	$("#writeVO").submit();
}
</script>

<!-- 개인정보수집동의 -->
<div class="bbs_agree_docs">
	<h4>개인정보 수집 동의 <span class="point">[필수]</span></h4>
	<div class="bbs_agree_text">
		<p class="text">광주환경공단은 환경소식지 의견게시 글쓰기를 위해 최소한의 개인정보를 아래와 같이 수집&middot;이용하고 있습니다.</p>
		<ul class="list_style">
			<li>수집 목적 : 환경소식지 의견게시 접수 및 처리</li>
			<li>수집 항목 : 이름, 비밀번호</li>
			<li>보유 이용기간 : <strong class="point">의견에 대한 답변 종료 시</strong></li>
		</ul>
		<p class="text">※ 정보주체께서는 개인정보 수집&middot;이용 동의를 거부할 권리가 있으며, 동의를 거부할 경우에는 환경소식지 의견게시에 제한을 받게 됩니다.</p>
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

<div class="bbs bbs_post bbs_<c:out value='${boardVO.dm_skin }'/>" id="bbs_<c:out value='${boardVO.dm_table }'/>">
	<p aria-hidden="true" class="mb15"><span class="required">*</span>표시된 입력값은 필수입력값입니다.</p>
	<form action="<c:out value='${param.root }'/>/write/set_write.do" name="writeVO" id="writeVO" method="post" enctype="multipart/form-data">
		<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
		<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
		<input type="hidden" name="dm_table" value="<c:out value='${boardVO.dm_table}'/>"/>
		<input type="hidden" name="type" value="insert"/>
		<input type="hidden" name="wr_board" id="wr_board" value="${boardVO.dm_id}"/>
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
								<c:if test="${is_admin}">
		        					<div class="custom-control custom-checkbox mr-3">
										<input type="checkbox" name="wr_is_notice" value="1" id="notice" class="custom-control-input">
										<label class="custom-control-label" for="notice"><em></em>공지</label>
									</div>
								</c:if>					
								<c:if test='${boardVO.dm_use_secret eq "1"}'>
									<div class="custom-control custom-checkbox mr-3">
										<input type="checkbox" name="wr_option" value="secret" id="secret" class="custom-control-input">
										<label class="custom-control-label" for="secret"><em></em>비밀글</label>
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
					<td><input type="text" name="wr_subject" id="wr_subject" class="form-control" placeholder="제목" required /></td>
				</tr>
				
				<c:choose>
					<c:when test="${DiamLoginVO.id eq null}">
						<tr>
							<th><label for="wr_name">작성자<span class="required">*</span></label></th>
							<td>
								<input type="text" name="wr_name" id="wr_name" class="form-control" placeholder="작성자"/>
							</td>
						</tr>
					</c:when>
					<c:otherwise>
						<input type="hidden" name="wr_name" id="wr_name" value="${DiamLoginVO.name}"/>
					</c:otherwise>
				</c:choose>
				
				<c:if test='${DiamLoginVO.id eq null}'>
					<tr class="write_password">
						<th><label for="wr_password">비밀번호<span class="required">*</span></label></th>
						<td>
							<input type="password" name="wr_password" id="wr_password" class="form-control" autocomplete="new-password" placeholder="비밀번호"/>
						</td>
					</tr>
				</c:if>
				
				<tr>
					<th><label for="wr_content">내용<span class="required">*</span></label></th>
					<td>
						<c:choose>
							<c:when test="${boardVO.dm_use_dhtml_editor eq 1}">
								<textarea id="wr_content" class="form-control" name="wr_content" placeholder="내용" style="width:100%"><c:out value="${dm_basic_content_editor}"/></textarea>
							</c:when>
							<c:otherwise>
								<textarea id="wr_content" class="form-control" name="wr_content" rows="5" placeholder="내용" style="width:100%"><c:out value="${dm_basic_content_normal}" escapeXml="false"/></textarea>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
				
				<c:if test="${boardVO.dm_use_link eq 1 && is_link eq true}">
					<c:forEach var="result" begin="0" end="1" varStatus="status">
						<tr>
							<th>
								<label for="wr_link<c:out value='${status.index + 1}'/>">
									<i class="fa fa-link fa-fw" aria-hidden="true"></i> 링크  #<c:out value='${status.index + 1}'/>
								</label>
							</th>
							<td>
								<input type="text" name="wr_link<c:out value='${status.index + 1}'/>" id="wr_link<c:out value='${status.index + 1}'/>" class="form-control" size="50" placeholder="링크 ${status.index + 1}">
							</td>
						</tr>
					</c:forEach>
				</c:if>
				
				<c:if test="${boardVO.dm_use_file eq 1 && is_file eq true}">
					<c:if test='${boardVO.dm_upload_count > 0 }'>
						<c:forEach var="result" begin="0" end="${boardVO.dm_upload_count - 1}" varStatus="status">
							<tr>
								<th>첨부파일<c:out value='${status.index + 1}'/></th>
								<td>
									<div class="filebox">
										<input class="upload-name" value="파일선택" disabled="disabled"/>
										<label for="file${status.index}">업로드</label>
										<input type="file" name="file" id="file${status.index}" class="upload-hidden"/>
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
			<button type="button" id="btn_write" class="btn_submit">전송</button>
		</div>
	</form>
</div>