<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	String dm_id = request.getParameter("dm_id") != null ? request.getParameter("dm_id") : "";
%>
<c:set var="dm_id" value="<%=dm_id%>"/>
<c:import url="/adm/page_header.do" />
<script>
var oEditors = [];

function createSE() {
	nhn.husky.EZCreator.createInIFrame({ 
	   	oAppRef : oEditors, 
	   	elPlaceHolder : "dm_content", //저는 textarea의 id와 똑같이 적어줬습니다.
	   	sSkinURI : "/js/egovframework/diam/se2/SmartEditor2Skin.html", //경로를 꼭 맞춰주세요!
	   	fCreator : "createSEditor2",
	   	htParams : { // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
		   	bUseToolbar : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
		   	bUseVerticalResizer : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		   	bUseModeChanger : true
	   	}
	});
}

function selectEvent(dm_id){
	$.ajax({
		url : "/adm/selectEvent.do",
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

$(function() {
	createSE();
	
	var dm_id = "<c:out value='${dm_id}'/>";
	if (dm_id != "") {
		selectEvent(dm_id);
	}
	    
	$("#fnSave").off().on('click', function () {
		if(confirm("정말로 저장하시겠습니까?")){
			fnSave();
		}
	});
	
	$("#fnCancel").off().on('click', function () {
		if(confirm("현재 진행 중인 작업이 있습니다. 정말 취소하시겠습니까?")){
			self.close();
		}
	});
});


function setValue(rows) {
	
	$("#dm_title").val(rows.dm_title);
	$("#dm_host").val(rows.dm_host);
	$("#dm_inquiry").val(rows.dm_inquiry);
	$("#dm_target").val(rows.dm_target);
	$("#dm_event_start").datebox("setValue", rows.dm_event_start);
	$("#dm_event_end").datebox("setValue", rows.dm_event_end);
	$("#dm_announce").datebox("setValue", rows.dm_announce);
/* 	$("#dm_twitter").val(rows.dm_twitter);
	$("#dm_instagram").val(rows.dm_instagram);
	$("#dm_naver").val(rows.dm_naver);
	$("#dm_facebook").val(rows.dm_facebook);
	$("#dm_youtube").val(rows.dm_youtube);
	$("#dm_kakao").val(rows.dm_kakao);
	$("#dm_etc").val(rows.dm_etc); */

	$("#dm_status").combobox({
		onLoadSuccess: function(){
			$("#dm_status").combobox("setValue", rows.dm_status);
		}
	});
	
	$("#dm_content").val(rows.dm_content);
	if (rows.dm_file_path != "") {
		$("#file").toggle();
		$("#file").after(
				'<div><p><img src="'+rows.dm_file_path+'" style="width: 30%;"></p>'+
				'<input type="hidden" name="dm_file_path" value="'+rows.dm_file_path+'">'+
				'<input type="hidden" name="dm_file_name" value="'+rows.dm_file_name+'">'+
				rows.dm_file_name +'<button type="button" class="btn btn-08 reset" style="float:right;">수정/삭제</button></div>'
		);
	}
	
	//oEditors.getById["dm_content"].exec("SET_IR", [""]); //내용초기화
	//oEditors.getById["dm_content"].exec("PASTE_HTML", [rows.dm_content]);
}

$(document).on("click", ".reset", function(){
	$(this).closest("div").siblings("input").toggle();
	$(this).closest("div").remove();
});


function fnSave() {
	
	if ($("#dm_title").val() == "") {
		alert("제목을 입력하세요.");
		return;
	}
	if ($("#dm_host").val() == "") {
		alert("주최를 입력하세요.");
		return;
	}
	if ($("#dm_inquiry").val() == "") {
		alert("문의처를 입력하세요.");
		return;
	}
	if ($("#dm_target").val() == "") {
		alert("응모대상을 입력하세요.");
		return;
	}
	if ($("#dm_event_start").datebox("getValue") == "") {
		alert("시작일을 입력하세요.");
		return;
	}
	if ($("#dm_event_end").datebox("getValue") == "") {
		alert("종료일을 입력하세요.");
		return;
	}
	if ($("#dm_announce").datebox("getValue") == "") {
		alert("발표일을 입력하세요.");
		return;
	}
	var file = $("#file")[0].files[0];
	if (file == null && $("#dm_file_path").val() == null) {
		alert("썸네일을 등록하세요.");
		return;
	}
	
	$(".btnWrap").hide();
	
	oEditors.getById["dm_content"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var form = $("#fm")[0];
    var formData = new FormData(form);
    $.ajax({
        url: "/adm/upsertEvent.do",
        dataType:"json",
        type:"post",
        data:formData,
        async : false,
        contentType : false,
        processData : false,
        success: function(response){
            if(response.result == "success") {
            	window.opener.$.messager.alert('알림', response.notice, 'info');
            	window.opener.$("#dg").datagrid('reload');
                self.close();
            } else {
            	$.messager.alert('경고', response.notice, 'warning');
            	$(".btnWrap").show();
            }
        }, error:function(request,status,error) {
        	if (request.status == "303") {
				location.replace("/adm/login.do");
			} else {
				$.messager.alert('경고',request.responseJSON.notice,'warning');
	        	$(".btnWrap").show();
			}
        }
    });
}
</script>
<div class="easyui-layout">
    <div id="form_wrap">
    	<form id="fm" name="fm" method="post">
    		<c:if test="${!empty dm_id}">
		    	<input type="hidden" name="dm_id" value="<c:out value='${dm_id}'/>"/>
    		</c:if>
	        <div class="title">
	            <h1>이벤트 관리</h1>
				<div class="btnWrap">
	                <button type="button" id="fnSave">저장</button>
	                <button type="button" id="fnCancel" class="bt09">취소</button>
	            </div>
	        </div>
	        <div class="page">
	            <h3>이벤트 정보</h3>
	            <p class="required_text"><span class="required_value">*</span>표시된 입력값은 필수입력값입니다.</p>
	            <dl>
	                <dt>이벤트 제목<span class="required_value">*</span></dt>
	                <dd>
	                	<input type="text" name="dm_title" id="dm_title" maxlength="100" autocomplete="off">
	                	<p class="noty">1자 이상 100자 이하로 입력해주세요.</p>
	                </dd>
	            </dl>
	            <dl>
	                <dt>진행 상태<span class="required_value">*</span></dt>
	                <dd>
	                	<select id="dm_status" name="dm_status" class="easyui-combobox" panelHeight="auto"
	                                    data-options="url: '/adm/select_code.do?dm_code_group=3003',
	                                                    method: 'get',
	                                                    valueField: 'dm_code_value',
	                                                    textField: 'dm_code_name',
	                                                    editable: false" >
	                    </select>
	                </dd>
	                <dt>주최<span class="required_value">*</span></dt>
	                <dd>
	                	<input name="dm_host" id="dm_host" type="text" autocomplete="off">
	                </dd>
	            </dl>
	            <dl>
	                <dt>문의처<span class="required_value">*</span></dt>
	                <dd>
	                	<input name="dm_inquiry" id="dm_inquiry" type="text" autocomplete="off" >
	                </dd>
	                <dt>응모대상<span class="required_value">*</span></dt>
	                <dd>
	                	<input name="dm_target" id="dm_target" type="text" autocomplete="off" >
	                </dd>
	            </dl>
	            <dl>
	                <dt>시작일<span class="required_value">*</span></dt>
	                <dd>
	                	<input class="easyui-datebox" name="dm_event_start" id="dm_event_start" type="text" autocomplete="off" data-options="formatter:myformatter,parser:myparser,editable:false">
	                </dd>
	                <dt>종료일<span class="required_value">*</span></dt>
	                <dd>
	                	<input class="easyui-datebox" name="dm_event_end" id="dm_event_end" type="text" autocomplete="off" data-options="formatter:myformatter,parser:myparser,editable:false">
	                </dd>
	            </dl>
	            <dl>
	                <dt>발표일<span class="required_value">*</span></dt>
	                <dd>
	                	<input class="easyui-datebox" name="dm_announce" id="dm_announce" type="text" autocomplete="off" data-options="formatter:myformatter,parser:myparser,editable:false">
	                </dd>
	                <dt>썸네일<span class="required_value">*</span></dt>
	                <dd>
	                	<input name="file" id="file" type="file" accept="image/*">
	                </dd>
	            </dl>
	            <dl>
	            	<dt>내용<span class="required_value">*</span></dt>
	            	<dd class="zone">
	            		<textarea id="dm_content" name="dm_content"></textarea>
	            	</dd>
	            </dl>
<!-- 	            <dl>
	            	<dt>트위터 링크</dt>
	            	<dd>
	            		<input type="text" name="dm_twitter" id="dm_twitter" autocomplete="off"/>
	            	</dd>
	            	<dt>인스타 링크</dt>
	            	<dd>
	            		<input type="text" name="dm_instagram" id="dm_instagram" autocomplete="off"/>
	            	</dd>
	            </dl>
	            <dl>
	            	<dt>블로그 링크</dt>
	            	<dd>
	            		<input type="text" name="dm_naver" id="dm_naver" autocomplete="off"/>
	            	</dd>
	            	<dt>페이스북 링크</dt>
	            	<dd>
	            		<input type="text" name="dm_facebook" id="dm_facebook" autocomplete="off"/>
	            	</dd>
	            </dl>
	            <dl>
	            	<dt>유튜브 링크</dt>
	            	<dd>
	            		<input type="text" name="dm_youtube" id="dm_youtube" autocomplete="off"/>
	            	</dd>
	            	<dt>카카오 링크</dt>
	            	<dd>
	            		<input type="text" name="dm_kakao" id="dm_kakao" autocomplete="off"/>
	            	</dd>
	            </dl>
	            <dl>
	            	<dt>기타 링크</dt>
	            	<dd>
	            		<input type="text" name="dm_etc" id="dm_etc" autocomplete="off"/>	            	
	            	</dd>
	            </dl> -->
	        </div>
	    </form>
    </div>    
</div>
<c:import url="/adm/page_bottom.do"/>