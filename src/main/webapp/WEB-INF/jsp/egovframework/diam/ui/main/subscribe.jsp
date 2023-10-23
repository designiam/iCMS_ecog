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
function doSearch() {
    var search_type = $('#search_type').val();
    var search_value = $('#stx').val();
    
   	$('#dg').datagrid('load',
        {
         	search_type : search_type,
         	search_value : search_value
        }
   	);
}

function allList() {
    $("#dg").datagrid('load', {
        search_type : '',
     	search_value : ''
    });
}
    
function formatDetail(value,row){
	str = '<a data-id="'+row.dm_id+'" data-status="'+row.dm_status+'" class="btn bt08 status">삭제</a>';
    return str;
}

$(document).on("click", ".status", function(){
	var pk = $(this).data("id");
	
	if (confirm(status + "삭제하시겠습니까?")) {
		$.ajax({
			url: "/adm/updateSubsStatus.do",
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

    $("#fnExcel").off().on('click', function () {
		$.messager.confirm("엑셀다운로드", "엑셀 다운로드를 하시겠습니까?<br> 데이터의 크기에 따라 시간이 <br>소요될 수있습니다.<br>", function (r) {
			if(r){
	            $.ajax({
	            	url : "/adm/getSubscribeExcel.do",
	            	data : {},
	            	type : "get",
	            	success: function(data){
	            		if (data.result == "success") {
	            			var downloadLink = document.createElement("a");
	           	          	downloadLink.href = data.rows;
	
	           	          	document.body.appendChild(downloadLink);
	           	          	downloadLink.click();
	           	         	document.body.removeChild(downloadLink);
						}
	            	}, error: function(request, status, error) {
        				$.messager.alert("error", request.responseJSON.notice, "warning");
	            	}
	            });
			}
		});
	});
});
</script>
<div id="load">
    <i class="fa fa-spinner fa-pulse fa-fw"></i>
</div>
<div class="easyui-layout" fit="true">
    <div data-options="region:'north', border:false">
        <div class="title">
            <h1>구독자 관리</h1>
        </div>
        <div class="Srchbox">
            <div>
                <dl>
                    <dt><strong>통합검색</strong></dt>
                    <dd>
                        <select name="search_type" id="search_type">
                            <option value="">통합검색</option>
                            <option value="dm_name">이름</option>
                            <option value="dm_email">이메일</option>
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
               data-options="pagePosition:'top',rownumbers:true,pagination:true, url:'/adm/selectSubsList.do',method:'get',fitColumns:true,striped:false,footer:'#ft'"
               pageList="[10]" pageSize="10" fit="true">
            <thead>
	            <tr>
	                <th data-options="field:'dm_name',width:100,align:'center'">이름</th>
	                <th data-options="field:'dm_email',width:150,align:'center'">이메일</th>
	                <th data-options="field:'status_text',width:70,align:'center'">상태</th>
	                <th data-options="field:'dm_create_dt',width:100,align:'center'">구독일</th>
	                <th field ="detail" width="50" formatter="formatDetail" align="center">관리</th>
	            </tr>
            </thead>
        </table>
    </div>
    <div data-options="region:'south'">
	    <dl class="Tbottom">
	        <dd>
                <button class="btn excel" id="fnExcel">엑셀다운로드</button>
            </dd>
	    </dl>
	</div>
</div>
<c:import url="/adm/page_bottom.do" />
