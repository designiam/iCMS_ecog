<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<c:import url="/adm/page_header.do" />
<script>
var uWidth = 1024;
var uHeight = 800;
var option = "scrollbars=auto,toolbar=no,location=no,status=no,menubar=no,resizable=yes,titlebar=no,width="+uWidth+",height="+uHeight+",left=0,top=0";

function fnNew() {
	window.open('<c:url value="/adm/file_form.do"/>',"new_file",option);
}

function fnRemove(){
    var ids = [];
    var dm_table = [];
    var rows = $('#dg').datagrid('getChecked');
    if (rows.length > 0) {
    	$.messager.confirm("", "정말 삭제하시겠습니까?", function (r) {
    		if (r) {
    			for(var i=0; i<rows.length; i++){
                    ids.push(rows[i].wr_id);
                    dm_table.push(rows[i].dm_table);
                }
    			$.ajaxSetup({ async:false });
                $.post("<c:url value='/adm/delete_write.do'/>",{wr_id:ids, dm_table:dm_table},function(result){
                	$.messager.alert('경고', result.notice, 'warning');
                },'json')
                $('#dg').datagrid('reload');    // reload the user data
    		}
    	});        	
    } else {
        $.messager.alert('경고', "삭제할 항목을 선택해주세요", 'warning');
    }
}

function doSearch() {
    var search_start_date = $("#search_start_date").datebox('getValue');
    var search_end_date= $("#search_end_date").datebox('getValue');
    var search_type = $('#search_type').val();
    var search_value = $('#stx').val();
	
    if (searchDateCheck(search_start_date, search_end_date)) {
    	$('#dg').datagrid('load',
   	        {
   	            search_start_date : search_start_date,
   	            search_end_date : search_end_date,
   	            search_type : search_type,
   	            search_value : search_value
   	        }
   	    );
    } else {
    	$.messager.alert('경고', "검색 시 시작일이 종료일보다 이후일 수 없습니다.", 'warning');
    }    
}

function allList() {
    $("#search_type").val('');
    $("#stx").val('');
    $("#search_start_date").datebox('setValue', '<c:out value="${ymd}"/>');
    $("#search_end_date").datebox('setValue', '<c:out value="${ymd}"/>');
    $("#search_board").combobox('reload');

    $("#dg").datagrid('load', {
        search_type: '',
        search_value : '',
        search_board : ''
    });
}

function formatDetail(value,row){
	var str = "";
	str += '<a data-id="'+row.dm_id+'" data-ext="'+row.dm_ext+'" class="btn bt08 url_copy" target="_blank">복사</a> ';
	str += '<a data-id="'+row.dm_id+'" class="btn bt08 open_form" target="_blank">확인</a>';
	return str;
}

$(function () {
	$('#dg').datagrid({
        emptyMsg:'데이터가 없습니다.',
	 	onLoadError: function(data) {
	 		alert('도메인리스트를 불러오던 중 오류가 발생하였습니다.');
	 	}
    });

    $("#fnNew").off().on('click', function () {
        fnNew();
    });

    $("#fnRemove").off().on('click', function () {
        fnRemove();
    });

    $("#search_btn").off().on('click', function () {
        doSearch();
    });

    var pager = $('#dg').datagrid('getPager');
    pager.pagination ({
        showPageList: true,
        layout:['info','sep','first','prev','links','next','last','list'],
        displayMsg : "검색 <strong>{to}</strong> 개 / 전체 <strong>{total}</strong> 개"
    });
    
    $(document).on('click', ".open_form", function () {
        var dm_id = $(this).data("id");
        window.open("/adm/file_form.do?dm_id="+dm_id, "file_detail",option);
    });
    $(document).on('click', ".url_copy", function () {
        var dm_id = $(this).data("id");
        var ext = $(this).data("ext");
        
        var protocol = window.location.protocol;
    	var url = window.location.host;
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
        
    });
});
</script>
<script type="text/javascript" src="https://www.jeasyui.com/easyui/datagrid-detailview.js"></script>
<div class="easyui-layout" fit="true">
    <div data-options="region:'north', border:false">
        <div class="title">
            <h1>이미지/pdf 등록</h1>
            <div class="btnWrap">
                <button id="fnNew" class="bt01">파일등록</button>
            </div>
        </div>
        <div class="Srchbox">
            <div>
                <dl>
                    <dt><strong>기간</strong></dt>
                    <dd>
                        <input type="text" class="easyui-datebox" id="search_start_date" value="" data-options="formatter:myformatter,parser:myparser"> ~
                        <input type="text" class="easyui-datebox" id="search_end_date" value="" data-options="formatter:myformatter,parser:myparser">
                        <a onclick="DateSearch.getToday();" class="btn">오늘</a>
                        <a onclick="DateSearch.getThisWeek();" class="btn">이번주</a>
                        <a onclick="DateSearch.getThisMonth();" class="btn">이번달</a>
                        <a onclick="DateSearch.getNextSevenDays()" class="btn">1주일</a>
                        <a onclick="DateSearch.getNextFiftheenDays()" class="btn">15일</a>
                        <a onclick="DateSearch.getMonthAgo()" class="btn">1개월</a>
                        <a onclick="DateSearch.getThreeMonthAgo()" class="btn">3개월</a>
                        <a onclick="DateSearch.getSixMonthAgo()" class="btn">6개월</a>
                        <a onclick="DateSearch.resetDate()" class="btn">전체</a>
                    </dd>
                </dl>
                <dl>
                    <dt><strong>통합검색</strong></dt>
                    <dd>
                        <select name="search_type" id="search_type">
                            <option value="">통합검색</option>
                            <option value="dm_org_file">파일명</option>
                            <option value="dm_etc">설명</option>
                        </select>
                        <input type="text" name="search_value" id="stx" maxlength="20" placeholder="검색어는 20글자까지 입력가능합니다." autocomplete="off" onkeyup="setTextPattern(this);">
                    </dd>
                </dl>
            </div>
            <button class="btn bt00" id="search_btn">검색</button>
            <button class="btn" onclick="allList()">초기화</button>
        </div>
    </div>
    <div data-options="region:'center', border:false" class="Contents">
        <table id="dg"
               class="easyui-datagrid" fit="true" border="false"
               data-options="pagePosition:'top',rownumbers:true,pagination:true,singleSelect:true,url:'<c:url value="/adm/selectFileList.do"/>',method:'post',fitColumns:true,striped:false,selectOnCheck:false,checkOnSelect:false" pageList="[10,20,30,50,70,100]" pageSize="20" fit="true">
            <thead>
            <tr>
                <th data-options="field:'dm_id',width:20,align:'center'">파일번호</th>
                <th data-options="field:'dm_create_dt',width:60,align:'center'">생성날짜</th>
                <th data-options="field:'dm_org_name',width:100,align:'center'">파일명</th>
                <th data-options="field:'dm_file_name',width:140,align:'center'">저장파일명</th>
                <th data-options="field:'dm_path',width:40,align:'center'">경로</th>
                <th data-options="field:'dm_type',width:35,align:'center'">타입</th>
                <th data-options="field:'dm_ext',width:20,align:'center'">확장자</th>
                <th data-options="field:'dm_size',width:30,align:'center'">크기</th>
                <th data-options="field:'dm_etc',width:80,align:'center'">설명</th>
                <th field ="detail" width="50" formatter="formatDetail" align="center">관리</th>
            </tr>
            </thead>
        </table>
    </div>
<!--     <div data-options="region:'south'">
        <dl class="Tbottom">
            <dd>
                <button class="btn" id="fnRemove">선택삭제</button>
            </dd>
        </dl>
    </div> -->
</div>
<c:import url="/adm/page_bottom.do" />