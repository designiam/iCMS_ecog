<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/adm/page_header.do" />
<style>
	.Srchbox dl button {
		margin: 0 5px;
	}
    #load {width: 100%;height: 100%;top: 0;left: 0;position: fixed;background:rgba(255,255,255,0.8);z-index:99;text-align: center; display: none;}
    #load >i{position: absolute;top: 50%;left: 50%; z-index: 100; transform: translate(-50%,-50%); font-size:3rem}
</style>
<script>
$(document).on("click", ".Srchbox dl button", function(){
	var type = $(this).data("type");
	var typeText = type == "1" ? "인스타그램" : "유튜브";
	if (confirm(typeText + " 데이터 크롤링을 시작하시겠습니까?\n작업은 최대 수 분 소요될 수 있습니다.")) {
		$.ajax({
			url: "/adm/startCrawling.do",
			data: {
				type : type
			},
			type: "post"
		}).done(function(response){
			if (response.result == "success") {
				$.messager.alert("info", response.notice, "info");
				$("#dg").datagrid("reload");
			} else {
				$.messager.alert("info", response.notice, "info");
			}
		}).fail(function(response, status, error){
			$.messager.alert("error", response.responseJSON.notice, "warning");
		});
	}
});

$(function(){
	$(document).ajaxStart(function(){
		$("#load").show();
	});
	$(document).ajaxStop(function(){
		$("#load").hide();
	});
});

function doSearch() {
    var search_status = $('#search_status').combobox('getValue');
    
   	$('#dg').datagrid('load',
        {
         	dm_status : search_status
        }
   	);
}

function allList() {
    $("#dg").datagrid('load', {
        dm_status: ''
    });
}
    
function formatDetail(value,row){
	str = '<a data-id="'+row.dm_id+'" data-status="'+row.dm_status+'" class="btn bt08 status">상태 변경</a>';
    return str;
}

$(document).on("click", ".status", function(){
	var pk = $(this).data("id");
	var status = $(this).data("status") == "사용" ? "사용안함" : "사용";
	
	if (confirm(status + " 상태로 변경하시겠습니까?")) {
		$.ajax({
			url: "/adm/changeCrawlStatus.do",
			data: {
				dm_id : pk
			},
			type: "post"
		}).done(function(response){
			if (response.result == "success") {
				$.messager.alert("info", response.notice, "info");
				$("#dg").datagrid("reload");
			} else {
				$.messager.alert("warning", response.notice, "warning");
			}
		}).fail(function(request, status, error){
			if (request.status == "303") {
				location.replace("/adm/login.do");
			} else {
				$.messager.alert("error", request.responseJSON.notice, "warning");
			}
		});
	}
});

$(document).ready(function() {
    $("#search_btn").off().on('click', function () {
        doSearch();
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

});
</script>
<div id="load">
    <i class="fa fa-spinner fa-pulse fa-fw"></i>
</div>
<div class="easyui-layout" fit="true">
    <div data-options="region:'north', border:false">
        <div class="title">
            <h1>SNS 데이터</h1>
        </div>
        <div class="Srchbox">
            <div>
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
                    <dd style="text-align: right;">
                    	<button data-type="1" class="btn" style="border-radius: 5px; border: none; color: white !important; background: rgb(252,176,69);
							background: -moz-linear-gradient(49deg, rgba(252,176,69,1) 000%, rgba(253,29,29,1) 50%, rgba(131,58,180,1) 100%);
							background: -webkit-linear-gradient(49deg, rgba(252,176,69,1) 000%, rgba(253,29,29,1) 50%, rgba(131,58,180,1) 100%);
							background: linear-gradient(49deg, rgba(252,176,69,1) 000%, rgba(253,29,29,1) 50%, rgba(131,58,180,1) 100%);
							filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=''#fcb045',endColorstr='#833ab4',GradientType=1); ">인스타그램</button>
                    	<button data-type="2" class="btn bt06" style="border-radius: 5px; border: none; background-color: #D3262C !important;">유튜브</button>
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
               data-options="pagePosition:'top',rownumbers:true,pagination:true, url:'/adm/selectCrawlData.do',method:'post',fitColumns:true,striped:false,footer:'#ft'"
               pageList="[10]" pageSize="10" fit="true">
            <thead>
	            <tr>
	                <th data-options="field:'dm_type',width:70,align:'center'">타입</th>
	                <th data-options="field:'dm_src',width:100,align:'center'">이미지</th>
	                <th data-options="field:'dm_href',width:150,align:'center'">링크</th>
	                <th data-options="field:'dm_status',width:70,align:'center'">상태</th>
	                <th data-options="field:'dm_create_dt',width:100,align:'center'">등록일</th>
	                <th field ="detail" width="50" formatter="formatDetail" align="center">관리</th>
	            </tr>
            </thead>
        </table>
    </div>
</div>
<c:import url="/adm/page_bottom.do" />
