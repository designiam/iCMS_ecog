<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/adm/page_header.do" />
<script>
var uWidth = 1024;
var uHeight = 768;
var option = "scrollbars=auto,toolbar=no,location=no,status=no,menubar=no,resizable=yes,titlebar=no,width="+uWidth+",height="+uHeight+",left=0,top=0";

function doSearch() {
    var search_type = $('#search_type').val();
    var search_value = $('#stx').val();
    var search_start_date = $('#search_start_date').datebox('getValue');
    var search_end_date = $('#search_end_date').datebox('getValue');
    var search_status = $('#search_status').combobox('getValue');
    
    if (searchDateCheck(search_start_date, search_end_date)) {
    	$('#dg').datagrid('load',
   	        {
   	            search_type : search_type,
   	            search_value : search_value,
   	            search_start_date : search_start_date,
   	            search_end_date : search_end_date,
   	         	dm_status : search_status
   	        }
   	   	);
    } else {
    	$.messager.alert('경고', "검색 시 시작일이 종료일보다 이후일 수 없습니다.", 'warning');
    }    
}

function fnNew() {
    window.open("/adm/cover_form.do","cover_new",option);
}

function fnRemove() {
    var ids = [];
    var rows = $('#dg').datagrid('getChecked');
    if (rows.length > 0) {
    	$.messager.confirm("", "정말 삭제하시겠습니까?", function (r) {
    		if (r) {
    			for(var i=0; i<rows.length; i++){
    	            ids.push(rows[i].dm_id);
    	        }
    			$.ajax({
    				url: "/adm/deleteCover.do",
    				data: {dm_id : ids},
    				type: "post"
    			}).done(function(response){
    				$.messager.alert('경고', response.notice , 'warning');
	                $('#dg').datagrid('reload');
    			}).fail(function(request, status, error) {
    				if (request.status == "303") {
    					location.replace("/adm/login.do");
    				} else {
    					$.messager.alert("error", request.responseJSON.notice, "warning");
    				}
    	        });
    		}
    	});
    } else {
        $.messager.alert('경고', "삭제할 항목을 선택해주세요", 'warning');
    }
}

function allList() {
    $("#search_type").val('');
    $("#stx").val('');
    $("#search_status").combobox('setValue', '');
    $("#search_start_date").datebox('setValue', '');
    $("#search_end_date").datebox('setValue', '');
    
    $("#dg").datagrid('load', {
    	search_start_date: '',
    	search_end_date: '',
        search_type: '',
        search_value : ''
    });
}
    
function formatDetail(value,row){
	str = '<a data-id="'+row.dm_id+'" class="btn bt08 open_form" target="_blank">수정</a>';
    return str;
}

$(document).ready(function(){
	$("#stx").keypress(function(e){
        if(e.keyCode === 13){
            e.preventDefault();
            doSearch();
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

    $("#fnKick").off().on('click', function () {
        fnKick();
    });
	
    $('#dg').datagrid({
        emptyMsg: '데이터가 없습니다.',
 	 	onLoadError: function(request, status, error) {
 	 		if (request.status == "303") {
				location.replace("/adm/login.do");
			} else {
				$.messager.alert("error", request.responseJSON.notice, "warning");
			}
	 	}
    });
    
    var pager = $('#dg').datagrid('getPager');
    pager.pagination ({
        showPageList: true,
        layout:['info','sep','first','prev','links','next','last','list'],
        displayMsg : "검색 <strong>{to}</strong> 개 / 전체 <strong>{total}</strong> 개"
    });

    $(document).on('click', ".open_form", function () {
        var dm_id = $(this).data("id");
        window.open("/adm/cover_form.do?dm_id="+dm_id, "cover_detail",option)
    });

});
</script>

<div class="easyui-layout" fit="true">
    <div data-options="region:'north', border:false">
        <div class="title">
            <h1>표지 관리</h1>
            <div class="btnWrap">
                <button id="fnNew" class="bt01">신규생성</button>
            </div>
        </div>
        <div class="Srchbox">
            <div>
                <dl>
                    <dt><strong>발행일</strong></dt>
                    <dd>
                        <input type="text" class="easyui-datebox" id="search_start_date" value="" data-options="formatter:myformatter,parser:myparser,editable:false"> ~
                        <input type="text" class="easyui-datebox" id="search_end_date" value="" data-options="formatter:myformatter,parser:myparser,editable:false">
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
                    <dt><strong>상태</strong></dt>
                    <dd>
                        <select id="search_status" class="easyui-combobox" panelHeight="auto"
                                data-options="url: '/adm/select_code.do?dm_code_group=1001&search=1',
                                            method: 'get',
                                            valueField: 'dm_code_value',
                                            textField: 'dm_code_name',
                                            editable: false">
                        </select>
                    </dd>
                </dl>
                <dl>
                    <dt><strong>통합검색</strong></dt>
                    <dd>
                        <select name="search_type" id="search_type">
                            <option value="">통합검색</option>
                            <option value="dm_vol">호수</option>
                            <option value="dm_title">제목</option>
                        </select>
                        <input type="text" name="search_value" id="stx" maxlength="20" placeholder="검색어는 20글자까지 입력가능합니다." autocomplete="off">
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
               data-options="pagePosition:'top',rownumbers:true,pagination:true,singleSelect:true,url:'/adm/selectCoverList.do',method:'post',fitColumns:true,striped:false,selectOnCheck:false,checkOnSelect:false" pageList="[10,20,30,50,70,100]" pageSize="50" fit="true">
            <thead>
            <tr>
                <th data-options="field:'ck',width:100,align:'center',checkbox:true,
                editor:{
                    type:'checkbox',
                    options:{
                        on:'Y',
                        off:'N'
                    }
                }"></th>
                <th data-options="field:'dm_vol',width:100,align:'center'">vol</th>
                <th data-options="field:'dm_year',width:100,align:'center'">발행일</th>
                <th data-options="field:'dm_title',width:150,align:'center'">제목</th>
                <th data-options="field:'dm_status',width:70,align:'center'">상태</th>
                <th data-options="field:'dm_create_dt',width:100,align:'center'">등록일</th>
                <th data-options="field:'dm_create_id',width:100,align:'center'">등록자</th>
                <th data-options="field:'dm_modify_dt',width:100,align:'center'">수정일</th>
                <th data-options="field:'dm_modify_id',width:100,align:'center'">수정자</th>
                <th field ="detail" width = "120" formatter="formatDetail" align="center">관리</th>
            </tr>
            </thead>
        </table>
    </div>
    <div data-options="region:'south'">
        <dl class="Tbottom">
            <dd>
                <button class="btn" id="fnRemove">선택삭제</button>
            </dd>
        </dl>
    </div>
</div>
<c:import url="/adm/page_bottom.do" />
