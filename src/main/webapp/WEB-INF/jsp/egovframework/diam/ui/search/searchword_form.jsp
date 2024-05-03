<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	String dm_id = request.getParameter("dm_id") != null ? request.getParameter("dm_id").trim() : ""; 
	String type = "insert";
	if (dm_id != null && !"".equals(dm_id)) {
		type = "update";
	} else{
		type = "insert";
	}
%>
<c:set var="dm_id" value="<%=dm_id%>"/>
<c:set var="type" value="<%=type%>"/>
<c:import url="/adm/page_header.do" />
<div class="easyui-layout">
	<div id="form_wrap">
		<form id="fm" name="fm" action="" method="post">
	       	<input type="hidden" name="type" id="type" value="<c:out value='${type}'/>" /> 
	   	 	<c:if test='${type eq "update"}'>
	 			<input type="hidden" name="dm_id" id="dm_id" value="<c:out value='${dm_id}'/>" />
	        </c:if>
	        <div class="title">
	        	<h1>검색어관리</h1>
		        <div class="btnWrap">
			        <button type="button" id="fnSave"">저장</button>
			        <button type="button" id="fnCancel" class="bt09">취소</button>
		        </div>
	        </div>
	       	<div class="page">
	        	<h3>검색어정보</h3>
	        	<p class="required_text"><span class="required_value">*</span>표시된 입력값은 필수입력값입니다.</p>
				<dl>
					<c:choose>
						<c:when test="${type eq 'insert'}">
							<dt><label for="dm_domain">도메인선택<span class="required_value">*</span></label></dt>
						    <dd>
						        <select id="dm_domain" name="dm_domain" class="easyui-combobox" panelHeight="auto"
						          data-options="url: '/adm/select_domain_id.do',
										method: 'get',
										valueField: 'dm_id',
				                        textField: 'dm_domain_nm',
										editable: false">
						 		</select>
						    </dd>
						</c:when>
						<c:otherwise>
							<dt>도메인선택</dt>
							<dd>
								<span id="dm_domain_text"></span>
								<input type="hidden" name="dm_domain" id="dm_domain"/>
							</dd>
						</c:otherwise>
					</c:choose>				    
				</dl>
				<dl>
				    <dt><label for="dm_word">검색어<span class="required_value">*</span></label></dt>
				    <dd>
				        <input id="dm_word" name="dm_word" type="text" maxlength="20" autocomplete="off"/>
				        <c:if test='${type eq "insert"}'>
				        <p class="noty">검색어를 입력해주세요.</p>
				        </c:if>
				    </dd>
				</dl>
				<dl>
					<dt><label for="dm_count">검색횟수<span class="required_value">*</span></label></dt>
					<dd>
						<input id="dm_count" name="dm_count" type="text" autocomplete="off" onkeyup="setNumberPattern(this);"/>
						<p class="noty">숫자만 입력가능합니다.</p>
					</dd>
				</dl>
				<dl>
					<dt><label for="dm_sort">추천점수<span class="required_value">*</span></label></dt>
					<dd>
						<input id="dm_sort" name="dm_sort" type="text" autocomplete="off" onkeyup="setOrderPattern(this);"/>
						<p class="noty">숫자만 입력가능합니다. 숫자가 클수록 상단에 노출됩니다.</p>
					</dd>
				</dl>
			</div>
		</form>
	</div>	
</div>
<script>
function fnSave() {
    $(".btnWrap").hide();   
    var form = $("#fm")[0];
    var formData = new FormData(form);

    $.ajax({
        url : "/adm/set_search_word.do",
        data : formData,
        dataType: "json",
        type : "post",
        contentType: false,
        processData: false,
        success : function (data) {
        	if(data.result == "success") {
        		window.opener.$.messager.alert('알림', data.notice, 'info');
        		window.opener.$("#dg_data").datagrid('reload');
                self.close();
            } else {
            	$.messager.alert('경고', data.notice, 'warning');
            	 $(".btnWrap").show();
            }           
        }, error:function(request,status,error) {
        	if (request.status == "303") {
				location.replace("/adm/login.do");
			} else {
				$.messager.alert("error", request.responseJSON.notice, "warning");
	        	$(".btnWrap").show();
			}
        }
    });
}

$(function () {
	var dm_id = "<c:out value='${dm_id}'/>";
	if (dm_id != "") {
		$.ajax({
			url : "/adm/get_search_word.do",
			type : "POST",
			cache : false,
			async : true,
			dataType : "json",
			data : "dm_id="+dm_id,
			success : function (data) {
				if(data.result == "success") {
					$("#dm_id").val(data.rows.dm_id);
			        $("#dm_word").val(data.rows.dm_word).attr('readonly', true);;
			        $("#dm_count").val(data.rows.dm_count);
			        $("#dm_sort").val(data.rows.dm_sort);
			        $("#dm_domain").val(data.rows.dm_domain);
					$("#dm_domain_text").text(data.rows.dm_domain_text);
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
		
	$("#fnCancel").off().on('click', function () {
		if(confirm("현재 진행 중인 작업이 있습니다. 정말 취소하시겠습니까?")){
			self.close();
		}
	});
	
	$("#fnSave").off().on('click', function () {
		if(confirm("정말로 저장하시겠습니까?")){
			fnSave();
		}
    });
	
});
</script>
<c:import url="/adm/page_bottom.do" />