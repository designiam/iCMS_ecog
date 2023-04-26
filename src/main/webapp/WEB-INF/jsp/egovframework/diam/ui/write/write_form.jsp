<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String wr_id = request.getParameter("wr_id") != null ? request.getParameter("wr_id") : "";
	String wr_board = request.getParameter("wr_board") != null ? request.getParameter("wr_board") : "";
	
	String type = "";
	if (!"".equals(wr_id) && wr_id != null) {
		type = "update";
	} else {
		type = "insert";
	}
%>
<c:set var="type" value="<%=type%>"/>
<c:set var="wr_id" value="<%=wr_id%>"/>
<c:set var="wr_board" value="<%=wr_board%>"/>
<c:import url="/adm/page_header.do" />
<script type="text/javascript" src="/js/egovframework/diam/rsa/rsa.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/jsbn.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/prng4.js"></script>
<script type="text/javascript" src="/js/egovframework/diam/rsa/rng.js"></script>
<script>
var oEditors = [];

function selectWrite() {
	$.ajax({
		url : "/adm/get_write.do",
		type : "POST",
		cache : false,
		async : true,
		dataType : "json",
		data : {"wr_id" : "<c:out value='${wr_id}'/>"},
		success : function (data) {
			if(data.result == "success") {
        		data.rows.wr_file_array = data.wr_file_array;
        		data.rows.wr_file_ori_array = data.wr_file_ori_array;
        		fnSetData(data.rows);
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

function fnSetData(row) {
	$("#dm_table_text").text(row.dm_table_text);
	$("#wr_subject").val(unescapeHtml(row.wr_subject));
	$("#wr_content").val(row.wr_content);
	$("#wr_name").val(unescapeHtml(row.wr_name));
	$("#wr_link1").val(unescapeHtml(row.wr_link1));
	$("#wr_link2").val(unescapeHtml(row.wr_link2));
	if (row.ca_name != null && row.ca_name != "") {
	    $("#ca_name").combobox("reload", '/adm/get_category.do?wr_board='+row.wr_board+ '&selected=' + encodeURI(row.ca_name));
	}
		
	if (row.wr_option == 'secret') {
		$("#secret_option").prop("checked", true);
	}
	
	if (row.wr_is_notice == "1") {
	    $("#notice").prop("checked", true);
	}
	
	if (row.wr_file_array.length > 0) {
		for (var i=0; i<row.wr_file_array.length; i++) {
			var file_path = row.wr_file_array[i].split("/");
			if (row.wr_file_array[i] != '') {
				$(".file_td").eq(i).append(
				    row.wr_file_ori_array[i]+' <a href="/adm/get_write_file_download.do?wr_id='+row.wr_id+'&wr_board='+row.wr_board+'&file_name='+row.wr_file_array[i]+'&ori_file_name='+row.wr_file_ori_array[i]+'" class="file_link btn">다운로드</a>'+
				    "<label><input type='checkbox' name='del_file_"+i+"' class='file_link' id='del_file"+i+"' value='1'/>삭제</label>"
				);
			}
		}
	}
	
	if (row.mb_id == '비회원') {
		$(".write_password").show();
	}
	
	$("#wr_vol").val(row.wr_vol);
	$("input[name=wr_main][value="+row.wr_main+"]").prop("checked", true);
	$("#wr_direct").val(row.wr_direct);
	
	if (row.wr_head != null && row.wr_head != "") {
		$("#head").toggle();
		$("#head").after(
				'<div><img src="'+row.wr_path+row.wr_head+'">'+
				'<input type="hidden" name="wr_head" value="'+row.wr_head+'">'+
				row.wr_head.substr(15, row.wr_head.length -1)+'<button type="button" class="btn btn-08 reset" style="float:right;">수정/삭제</button></div>'
		);
	}
	
	if (row.wr_banner != null && row.wr_banner != "") {
		$("#banner").toggle();
		$("#banner").after(
				'<div><p><video src="'+row.wr_path+row.wr_banner+'" style="max-width:100%;" controls="controls"></p>'+
				'<input type="hidden" name="wr_banner" value="'+row.wr_banner+'">'+
				row.wr_banner.substr(15, row.wr_banner.length -1)+'<button type="button" class="btn btn-08 reset" style="float:right;">수정/삭제</button></div>'
		);
	}
	if (row.wr_background != null && row.wr_background != "") {
		$("#background").toggle();
		$("#background").after(
				'<div><img src="'+row.wr_path+row.wr_background+'">'+
				'<input type="hidden" name="wr_background" value="'+row.wr_background+'">'+
				row.wr_background.substr(15, row.wr_background.length -1)+'<button type="button" class="btn btn-08 reset" style="float:right;">수정/삭제</button></div>'
		);
	}
	if (row.wr_thumb != null && row.wr_thumb != "") {
		$("#thumbnail").toggle();
		$("#thumbnail").after(
				'<div><img src="'+row.wr_path+row.wr_thumb+'">'+
				'<input type="hidden" name="wr_thumb" value="'+row.wr_thumb+'">'+
				row.wr_thumb.substr(15, row.wr_thumb.length -1)+'<button type="button" class="btn btn-08 reset" style="float:right;">수정/삭제</button></div>'
		);
	}
}

$(document).on("click", ".reset", function(){
	$(this).closest("div").siblings("input").toggle();
	$(this).closest("div").remove();
});

function fnSave() {

	var banner = $("#banner")[0].files[0];
	if (banner != null) {
		if (banner.size > 52428800) {
			alert("파일 사이즈는 50MB를 초과할 수 없습니다.");
			return;
		}		
	}
	
	if ($("#wr_content").data("editor") == '1') {
		oEditors.getById["wr_content"].exec("UPDATE_CONTENTS_FIELD", []); //textarea의 id를 적어줍니다.		
	}
	
	<c:if test="${type eq 'update'}">
		var wr_password = $("#wr_password").val();
		if (wr_password != "" && wr_password != null) {
    		var rsa = new RSAKey();
    		rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
    		$("#wr_password").val(rsa.encrypt(wr_password));
    	}
	</c:if>
	
	switch ($("#skin").val()) {
		case "video":
			$(".gallery_only").remove();
			break;
		case "gallery":
			$(".video_only").remove();
			break;
		default:
			$("#wr_vol").val("-1");
			$(".video_only").remove();
			$(".gallery_only").remove();
			break;
	}
	
	if ($("#skin").val() != "basic") {
		if ($("#wr_vol").val() == "") {
			alert("발행 호수를 입력하세요");
			$(".btnWrap").show();
			return;
		}
	}
	
	$(".btnWrap").hide();
    var form = $("#fm")[0];
    var formData = new FormData(form);

    $.ajax({
        url : '/adm/set_write.do',
        data : formData,
        dataType: "json",
        type : "post",
        async: false,
    	cache: false,
    	contentType: false,
    	processData: false,
        success : function (data) {
        	if(data.result == "success") {
        		window.opener.$.messager.alert('알림', data.notice, 'info');
                window.opener.$("#dg").datagrid('reload');
                self.close();
            } else {
            	$.messager.alert('경고', data.notice, 'warning');
            	$("#wr_password").val("");
            	$(".btnWrap").show();
            }                
        }, error:function(request,status,error) {
        	console.log(request);
        	$(".btnWrap").show();
        	return;
        	if (request.status == "303") {
				location.replace("/adm/login.do");
			} else {
	        	$.messager.alert('경고',request.responseJSON.notice,'warning');
	        	$("#wr_password").val("");
	        	$(".btnWrap").show();
			}
        }
    });
}

function setBoardForm(boardId) {
    $.ajax({
        url : "/adm/get_board.do",
        type : "POST",
        async : false,
        dataType : "json",
        data : {"dm_id" : boardId},
        success : function (data) {
            if(data.result == "success") {
            	$(".file dd").html("");
            	$(".link dd").html("");
            	
            	var board_config = data.rows;
            	$("#skin").val(board_config.dm_skin);
            	switch (board_config.dm_skin) {
					case "video":
						$(".not_basic").show();
						$(".video_only").show();
						$(".gallery_only").hide();
						break;
					case "gallery":
						$(".not_basic").show();
						$(".video_only").hide();
						$(".gallery_only").show();
						break;
					default:
						$(".not_basic").hide();
						$(".video_only").hide();
						$(".gallery_only").hide();
						break;
				}
            	
            	if (board_config.dm_use_category == "1") {
                    $("#category").show();
                    $("#ca_name").combobox({
                        url : '/adm/get_category.do?wr_board='+board_config.dm_id,
                        valueField: 'dm_code_value',
                        textField: 'dm_code_name',
                        editable: false
                    });
                } else {
                    $("#category").hide();
                    $("#ca_name").combobox('setValue', '');
                }
				
                if (board_config.dm_use_file == "1") {
                	if (board_config.dm_upload_count > 0) {
                		for (var i=0; i<board_config.dm_upload_count; i++) {
                            $(".file dd").append("<p class='file_td'><input type='file' name='file' id='file"+i+"' style='width:70% !important;'/></p>");
                        }
                    }
                } else {
                	$(".file dd").append("<p class='noty'>첨부파일 설정이 없습니다. 게시판 > 게시판관리에서 첨부파일 사용/개수 설정을 해주세요.</p>");
                }
                
                if (board_config.dm_skin == "video") {
                	$(".link dd").append("<input type='text' class='wd80 mb5' name='wr_link1' id='wr_link1' placeholder='유튜브 영상 공유 URL을 입력해주세요. 예시) https://youtu.be/test'/>");
                	if (board_config.dm_use_link == "1") {
                		$(".link dd").append("<input type='text' class='wd80' name='wr_link2' id='wr_link2' placeholder='연결할 링크를 입력해주세요. 예시) http://diam.kr'/>");
                	}
				} else {
	                if (board_config.dm_use_link == "1") {
	                	for (var i=1; i<3; i++) {
	                		if (i == 1) {
	                			$(".link dd").append("<input type='text' class='wd80 mb5' name='wr_link"+i+"' id='wr_link"+i+"' placeholder='연결할 링크 "+i+"번 링크를 입력해주세요. 예시) http://diam.kr'/>");
	                		} else {
	                			$(".link dd").append("<input type='text' class='wd80' name='wr_link"+i+"' id='wr_link"+i+"' placeholder='연결할 링크 "+i+"번 링크를 입력해주세요. 예시) http://diam.kr'/>");
	                		}                		
	                	}
	                } else {
	                	$(".link dd").append("<p class='noty'>링크사용 설정이 없습니다. 게시판 > 게시판관리에서 링크사용 설정을 해주세요.</p>");
	                }
				}
                
				$("#wr_content").siblings().remove();
                if (board_config.dm_use_dhtml_editor == "1") {
                	$("#wr_content").data("editor", "1");
                	createSE();
				} else {
					$("#wr_content").show();
					$("#wr_content").data("editor", "0");
				}
				
                if (board_config.dm_use_secret == '1' && board_config.dm_skin == 'basic') {
                    $("#secret").show();
                } else {
                    $("#secret").hide();
                }
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

$(function () {
	$(".video_only").hide();
	$(".gallery_only").hide();
	$(".not_basic").hide();
	<c:if test="${type eq 'update'}">
		setBoardForm("<c:out value='${wr_board}'/>");
		selectWrite();
		//createSE();
	</c:if>
	<c:if test="${type eq 'insert'}">
		$("#wr_board").combobox({
			onChange: function(newValue){
				setBoardForm(newValue);
				$("#dm_id").val(newValue);
			}
		});
	</c:if>

    $("#fnSave").off().on('click', function () {
    	if(confirm("정말로 저장하시겠습니까?")){
        	fnSave();
    	}
    });
    
    $("#fnCancel").off().on('click', function(){
    	if(confirm("현재 진행 중인 작업이 있습니다. 정말 취소하시겠습니까?")){
    		self.close();
    	}
    });      
});

var createSE = function() {
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
}
</script>
<div class="easyui-layout">
	<div id="form_wrap">
		<form id="fm" method="post" enctype="multipart/form-data" name="fm" autocomplete="off">
			<input type="hidden" id="RSAModulus" value="${RSAModulus}"/>
			<input type="hidden" id="RSAExponent" value="${RSAExponent}"/>
			<input type="hidden" name="type" id="type" value="<c:out value='${type}'/>" />
			<input type="hidden" id="skin"/>
			<c:choose>
				<c:when test='${type eq "update"}'>
					<input type="hidden" name="wr_id" id="wr_id" value="<c:out value='${wr_id}'/>"/>
					<input type="hidden" name="wr_board" id="wr_board" value="${wr_board }">
					<input type="hidden" id="dm_id" value="${wr_board}" name="dm_id">
				</c:when>
				<c:otherwise>
					<input type="hidden" id="dm_id" name="dm_id">
				</c:otherwise>
			</c:choose>
			<div class="title">
				<h1>게시글관리</h1>
		        <div class="btnWrap">
			        <button type="button" id="fnSave">저장</button>
		            <button type="button" id="fnCancel" class="bt09">취소</button>
		        </div>
			</div>
			<div class="page">
				<h3>게시글 정보</h3>
				<p class="required_text"><span class="required_value">*</span>표시된 입력값은 필수입력값입니다.</p>
				<dl>
				    <c:choose>
						<c:when test="${type eq 'update'}">
							<dt>게시판 선택</dt>
							<dd id="dm_table_text">
							</dd>
						</c:when>
						<c:otherwise>
							<dt>게시판 선택<span class="required_value">*</span></dt>
							<dd>
							    <select id="wr_board" name="wr_board" class="easyui-combobox" panelHeight="auto"
							            data-options="url: '/adm/select_board.do',
							        method: 'get',
							        valueField: 'dm_id',
							        textField: 'dm_subject',
							        editable: false"></select>
							</dd>
						</c:otherwise>
					</c:choose>
				</dl>
				<dl id="category">
				    <dt>카테고리</dt>
				    <dd>
				        <select id="ca_name" name="ca_name" class="easyui-combobox" panelHeight="auto"></select>
				    </dd>
				</dl>
				<dl>
				    <dt>제목<span class="required_value">*</span></dt>
				    <dd>
				        <input type="text" name="wr_subject" id="wr_subject" class="wd80">
				        <label><input type="checkbox" name="wr_is_notice" value="1" id="notice">공지</label>
				        <label id="secret"><input type="checkbox" id="secret_option" name="wr_option" value="secret">비밀글</label>
				        <p class="noty">1자이상 255자 이하로 입력해 주세요.</p>
				    </dd>
				</dl>
				<dl>
				    <dt>작성자</dt>
				    <dd>
				        <input type="text" name="wr_name" id="wr_name" value="<c:out value='${DiamLoginVO.name}'/>">
				    </dd>
				</dl>
				<dl class="write_password" style="display:none;">
				    <dt>비밀번호</dt>
				    <dd>
				        <input type="password" name="wr_password" id="wr_password" autocomplete="new-password"/>
				        <p class="noty">비밀번호를 변경시에만 입력해주세요.</p>
				    </dd>
				</dl>
				<dl class="link">
					<dt>링크</dt>
					<dd></dd>
				</dl>				
				<dl class="file">
				    <dt>파일첨부</dt>
				    <dd></dd>
				</dl>
				<dl class="not_basic">
				    <dt>발행 호<span class="required_value">*</span></dt>
				    <dd><input type="text" name="wr_vol" id="wr_vol" onkeyup="setNumberPattern(this);"></dd>
				</dl>
				<dl class="not_basic">
				    <dt>타이틀 이미지</dt>
				    <dd><input type="file" name="head" id="head" accept="image/*"></dd>
				</dl>
				<dl class="gallery_only">
				    <dt>썸네일</dt>
				    <dd><input type="file" name="thumbnail" id="thumbnail" accept="image/*"></dd>
				</dl>
				<dl class="video_only">
					<dt>메인 게시 여부</dt>
					<dd>
						<label><input type="radio" name="wr_main" value="N" checked> 미사용</label>
						<label><input type="radio" name="wr_main" value="Y"> 사용</label>
					</dd>
				</dl>
				<dl class="video_only">
				    <dt>바로가기 링크</dt>
				    <dd>
				    	<input type="text" name="wr_direct" id="wr_direct" maxlength="200">
					    <p class="noty">http 프로토콜을 포함한 링크를 입력해주세요.</p>
				    </dd>
				</dl>
				<dl class="video_only">
				    <dt>영상 배너</dt>
				    <dd><input type="file" name="banner" id="banner" accept="video/*"></dd>
				</dl>
				<dl class="video_only">
				    <dt>배너 포스터</dt>
				    <dd><input type="file" name="background" id="background" accept="image/*"></dd>
				</dl>	
				<dl>
				    <dt>내용<span class="required_value">*</span></dt>
				    <dd>
				    	<textarea id="wr_content" name="wr_content"></textarea>
				    </dd>
				</dl>
			</div>
		</form>
	</div>	
</div>
<c:import url="/adm/page_bottom.do" />