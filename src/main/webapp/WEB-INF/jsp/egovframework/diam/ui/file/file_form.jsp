<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String dm_id = request.getParameter("dm_id") != null ? request.getParameter("dm_id") : "";
%>
<c:set var="dm_id" value="<%=dm_id%>"/>
<c:import url="/adm/page_header.do" />
<style>
.file_icon {
	padding-right: 10px;
	vertical-align: sub;
}
</style>
<script>

function fnSave() {

	$(".btnWrap").hide();
           
    var form = $("#fm")[0];
    var formData = new FormData(form);
    
    $.ajax({
        url : "<c:url value='/adm/createFile.do'/>",
        data : formData,
        dataType: "json",
        type : "post",
        async : false,
        contentType: false,
        processData: false,
        success : function (data) {
        	if(data.result == "success") {
                alert(data.notice);
                window.opener.$("#dg").datagrid('reload');
                self.close();
            } else if (data.result == "expired") {
            	alert(data.notice);
            	location.reload();
            } else {
            	alert(data.notice);
            	$(".btnWrap").show();
            }                
        }, error:function(request,status,error) {
        	alert("오류가 발생하였습니다. 관리자에게 문의주세요.");
        	$(".btnWrap").show();
        }
    });
}

function fnCopy() {
	var dm_id = $("#dm_id").val();
	var protocol = window.location.protocol;
	var url = window.location.host;
	var ext = $("#dm_ext").val();
	var copyText = document.createElement("textarea");
	document.body.appendChild(copyText);
	var copy = "";
	if(ext.toLowerCase() == "pdf"){
		copy = protocol +"//"+ url+"/down/pdf.do?fileNo="+dm_id;
	} else {
		copy = protocol +"//"+ url+"/down/image.do?fileNo="+dm_id;
	}
	copyText.value = copy;
	copyText.select();
	document.execCommand('copy');
	document.body.removeChild(copyText);
	
	alert("URL : "+ copy + "\n복사가 완료되었습니다.");
	
}

function selectFile(dm_id){
	$.ajax({
		url : "/adm/selectFile.do",
		type : "get",
		async : true,
		dataType : "json",
		data : "dm_id="+dm_id,
		success : function (data) {
			if(data.result == "success") {
				setValue(data.rows);
			} else {
				window.opener.$.messager.alert('경고', data.notice, 'warning');
			    self.close();
			}
		}, error:function(request,status,error) {
			if (request.status == "303") {
				location.replace("/adm/login.do");
			} else {
				window.opener.$.messager.alert('경고',request.responseJSON.notice,'warning');
				self.close();
			}
		}
	});
}

function setValue(rows) {
	
	$("#dm_org_name").val(rows.dm_org_name);
	$("#dm_file_name").val(rows.dm_file_name);
	$("#dm_path").val(rows.dm_path);
	$("#dm_ext").val(rows.dm_ext);
	$("#dm_size").val(rows.dm_size);
	$("#dm_etc").val(rows.dm_etc);
	
	if(rows.dm_ext.toLowerCase() == "pdf"){
		$(".file_image").prepend('<div><a href="/down/pdf.do?fileNo='+rows.dm_id+'" target="_blank"><img class="file_icon" src="/images/file.png" />'+ rows.dm_org_name +'</a></div>');
	} else {
	    $(".file_image").prepend('<div><img style="max-width:500px;" src="'+rows.dm_path+rows.dm_file_name+'" alt="'+rows.dm_file_name+'"/></div>');		
	}

}

$(function () {
	
	var dm_id = "<c:out value='${dm_id}'/>";
	if (dm_id != "") {
		selectFile(dm_id);
	}
	
    $("#fnSave").off().on('click', function () {
    	if(confirm("정말로 저장하시겠습니까?")){
        	fnSave();
    	}
    });
    $("#fnCopy").off().on('click', function () {
    	fnCopy();
    });
    
    $("#fnCancel").off().on('click', function(){
    	if(confirm("현재 진행 중인 작업이 있습니다. 정말 취소하시겠습니까?")){
    		self.close();
    	}
    });
    
});

</script>
<div class="easyui-layout">
	<div id="form_wrap">
		<form id="fm" method="post" enctype="multipart/form-data" name="fm">
			<c:choose>
				<c:when test="${!empty dm_id}">
					<input type="hidden" id="dm_id" name="dm_id" value="<c:out value='${dm_id}'/>"/>
					<div class="title">
						<h1>상세정보</h1>
						<div class="btnWrap">
							<button type="button" id="fnCopy">복사</button>
				            <button type="button" id="fnCancel" class="bt09">취소</button>
				        </div>
					</div>
					<div class="page">
						<h3>파일번호 : <c:out value="${dm_id }"/></h3>
						<dl>
							<dt>파일명</dt>
							<dd><input type="text" id="dm_org_name" readonly="readonly"></dd>
						</dl>
						<dl>
							<dt>저장파일명</dt>
							<dd><input type="text" id="dm_file_name" readonly="readonly"></dd>
						</dl>
						<dl>
							<dt>경로</dt>
							<dd><input type="text" id="dm_path" readonly="readonly"></dd>
						</dl>
						<dl>
							<dt>확장자</dt>
							<dd><input type="text" id="dm_ext" readonly="readonly"></dd>
							<dt>크기</dt>
							<dd><input type="text" id="dm_size" readonly="readonly"></dd>
						</dl>
						<dl>
							<dt>설명</dt>
							<dd><input type="text" id="dm_etc" readonly="readonly"></dd>
						</dl>
						<dl>
							<dt>파일</dt>
							<dd class="file_image"></dd>
						</dl>
					</div>
				</c:when>
				<c:otherwise>
					<div class="title">
						<h1>파일등록</h1>
				        <div class="btnWrap">
					        <button type="button" id="fnSave">저장</button>
				            <button type="button" id="fnCancel" class="bt09">취소</button>
				        </div>
					</div>
					<div class="page">
						<h3>파일</h3>
				        <dl>
						    <dt>파일<span class="required_value">*</span></dt>
						    <dd>
						    	<input class="easyui-filebox" id="file" name="file" data-options="prompt:'리스트(이미지) 파일을 선택하세요',accept:'.jpg, .jpeg, .gif, .png, .pdf'">
						    	<p class="noty">이미지파일(jpg, jpeg, gif, png), pdf 파일만 등록 가능합니다.</p>
						    </dd>
						</dl>
						<dl>
							<dt>설명</dt>
							<dd>
								<input type="text" name="dm_etc" maxlength="20">
								<p class="noty">이미지설명을 20글자 이내로 입력해주시기 바랍니다.</p>
							</dd>
						</dl>
					</div>
				</c:otherwise>
			</c:choose>

		</form>
	</div>	
</div>
<c:import url="/adm/page_bottom.do" />