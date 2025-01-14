<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%
	String dm_id = request.getParameter("dm_id") != null ? request.getParameter("dm_id") : "";
%>
<c:set var="dm_id" value="<%=dm_id%>"/>
<%
Date today = new Date();
SimpleDateFormat format = new SimpleDateFormat("yyyy");
String year = format.format(today);			
%>
<c:set var="year" value="<%=year%>"/>
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

function selectCover(dm_id){
	$.ajax({
		url : "/adm/selectCover.do",
		type : "POST",
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
	setYear();
	setMonth();
	var dm_id = "<c:out value='${dm_id}'/>";
	if (dm_id != "") {
		selectCover(dm_id);
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
	
	$("#dm_content").val(rows.dm_content);
	$("#dm_title").val(rows.dm_title);
	$("#dm_vol").val(rows.dm_vol);
	$("#dm_year").val(rows.dm_year).prop("selected", true);
	$("#dm_month").val(rows.dm_month).prop("selected", true);
	$("#dm_status").combobox({
		onLoadSuccess: function(){
			$("#dm_status").combobox("setValue", rows.dm_status);
		}
	});
	//oEditors.getById["dm_content"].exec("PASTE_HTML", [$("#dm_content").val()]);
	
    if (rows.dm_cover_img != null && rows.dm_cover_img != "") {
    	$('.file_dd').append("<img src='/resources/cover/"+rows.dm_cover_img+"' style='max-width: 300px; margin-top:8px;'/><div><label><input type='checkbox' name='dm_cover_del_img' class='file_link' id='dm_cover_del_img' value='"+rows.dm_cover_img+"'/>삭제("+ rows.dm_cover_img_ori +")</label></div>");
    }
    $("#dm_link").val(unescapeHtml(rows.dm_link));
    $("#dm_link_type").combobox('reload', '/adm/select_code.do?dm_code_group=1005&selected='+rows.dm_link_type);


}



function fnSave() {
	$(".btnWrap").hide();
	
	oEditors.getById["dm_content"].exec("UPDATE_CONTENTS_FIELD", []);
	
	var form = $("#fm")[0];
    var formData = new FormData(form);
    $.ajax({
        url: "/adm/upsertCover.do",
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

function setYear() {
	var i = <c:out value='${year}'/>;
	var str = '<option value="">선택</option>';
	while (i >= 2015) {
		str += '<option value="'+i+'">'+i+'</option>';
		i--;
	}
	$("#dm_year").empty().append(str).css("width", "100%");
}

function setMonth(){
	var i = 1;
	var str = '<option value="">선택</option>';
	while (i < 13) {
		var j = i < 10 ? "0"+i : i;
		str += '<option value="'+j+'">'+j+'</option>'
		i++;
	}
	$("#dm_month").empty().append(str).css("width", "100%");
}
</script>
<div class="easyui-layout">
    <div id="form_wrap">
    	<form id="fm" name="fm" method="post">
    		<c:if test="${!empty dm_id}">
		    	<input type="hidden" name="dm_id" value="<c:out value='${dm_id}'/>"/>
    		</c:if>
	        <div class="title">
	            <h1>표지 관리</h1>
				<div class="btnWrap">
	                <button type="button" id="fnSave">저장</button>
	                <button type="button" id="fnCancel" class="bt09">취소</button>
	            </div>
	        </div>
	        <div class="page">
	            <h3>표지 정보</h3>
	            <p class="required_text"><span class="required_value">*</span>표시된 입력값은 필수입력값입니다.</p>
	            <dl>
	                <dt>표지 제목<span class="required_value">*</span></dt>
	                <dd>
	                	<input type="text" name="dm_title" id="dm_title" maxlength="100" autocomplete="off">
	                	<p class="noty">1자 이상 100자 이하로 입력해주세요.</p>
	                </dd>
	            </dl>
	            <dl>
	                <dt>호수<span class="required_value">*</span></dt>
	                <dd id="image">
	                   	<input type="text" id="dm_vol" name="dm_vol" onkeyup="setNumberPattern(this);" maxlength="10" autocomplete="off">
	                    <p class="noty">숫자만 입력가능합니다.</p>
	                </dd>
	            </dl>
	            <dl>
	                <dt>발행연도<span class="required_value">*</span></dt>
	                <dd>
	                	<!-- <input name="dm_year" id="dm_year" type="text" maxlength="4" autocomplete="off" > -->
	                	<select name="dm_year" id="dm_year">
	                	</select>
	                </dd>
	                <dt>발행월<span class="required_value">*</span></dt>
	                <dd>
	                	<!-- <input name="dm_month" id="dm_month" onkeyup="setNumberPattern(this);" type="text" maxlength="2" autocomplete="off"> -->
	                	<select name="dm_month" id="dm_month">
	                	</select>
	                </dd>
	            </dl>
	            <dl>
	            	<dt>내용</dt>
	            	<dd class="zone">
	            		<textarea id="dm_content" name="dm_content"></textarea>
	            	</dd>
	            </dl>
	            <dl>
	                <dt>이미지 파일<span class="required_value">*</span></dt>
	                <dd class="file_dd">
	                	<input type="file" name="multiFile" id="multiFile" accept=".jpg, .jpeg, .gif, .png">
	                	<p class="noty">.jpg, .jpeg, .gif, .png 확장자 파일만 업로드 가능합니다.</p>
	                </dd>
	            </dl>
	            <dl>
	                <dt>링크</dt>
	                <dd>
	                    <input type="text" name="dm_link" id="dm_link" maxlength="255" autocomplete="off">
	                    <p class="noty">연결하고자 하는 외부페이지의 <b>http 프로토콜을 포함한 링크</b>를 입력해주세요. 최대 255자 작성가능합니다.</p>
	                    <p class="noty">단순 게시용 배너일 경우 링크를 입력하지 않고 등록해주세요.</p>
	                </dd>
	            </dl>
	            <dl>
	                <dt>링크 타겟<span class="required_value">*</span></dt>
	                <dd>
	                	<select id="dm_link_type" name="dm_link_type" class="easyui-combobox" panelHeight="auto"
	                            data-options="url: '/adm/select_code.do?dm_code_group=1005',
	                                    method: 'post',
	                                    valueField: 'dm_code_value',
	                                    textField: 'dm_code_name',
	                                    editable: false">
	                    </select>
	                    <p class="noty">_self(메뉴 클릭 시 현재창에서 링크이동), _blank(메뉴 클릭 시 새창에서 링크이동)</p>
	                </dd>
	            </dl>
	            <dl>
	                <dt>사용여부<span class="required_value">*</span></dt>
	                <dd>
	                	<select id="dm_status" name="dm_status" class="easyui-combobox" panelHeight="auto"
	                                    data-options="url: '/adm/select_code.do?dm_code_group=1001',
	                                                    method: 'get',
	                                                    valueField: 'dm_code_value',
	                                                    textField: 'dm_code_name',
	                                                    editable: false" >
	                    </select>
	                    <p class="noty">사용안함의 경우 비활성화 됩니다.</p>
	                </dd>
	            </dl>
	        </div>
	    </form>
    </div>
</div>
<c:import url="/adm/page_bottom.do"/>