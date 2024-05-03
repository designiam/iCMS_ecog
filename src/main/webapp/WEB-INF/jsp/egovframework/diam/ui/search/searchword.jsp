<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/adm/page_header.do" />
<script>
var uWidth = 1024;
var uHeight = 768;
var option = "scrollbars=auto,toolbar=no,location=no,status=no,menubar=no,resizable=yes,titlebar=no,width="+uWidth+",height="+uHeight+",left=0,top=0";

function allList() {
    $("#search_type").val('');
    $("#stx").val('');
    $("#search_domain").combobox('reload');
    $("#dg_data").datagrid('load', {
        search_type: '',
        search_value : '',
        search_domain : ''
    });
}

function doSearch() {
    var search_type = $('#search_type').val();
    var search_value = $('#stx').val();
    var search_domain = $('#search_domain').combobox('getValue');
    $('#dg_data').datagrid('load',
        {   
    		search_type : search_type,
            search_value : search_value,
            search_domain : search_domain
        }
    );
}

function fnRemove() {
    var ids = [];
    var rows = $('#dg_data').datagrid('getChecked');
    if (rows.length > 0) {
    	$.messager.confirm("", "정말 삭제하시겠습니까?", function (r) {
    		if (r) {
    			for(var i=0; i<rows.length; i++){
        		    ids.push(rows[i].dm_id);
        		}
    			$.ajax({
    				url: "/adm/delete_search_word.do",
    				data: {dm_id : ids},
    				type: "post"
    			}).done(function(response){
    				$.messager.alert('경고', response.notice , 'warning');
                 $('#dg_data').datagrid('reload');
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

function formatDetail(value,row){
    return '<a class="btn bt08 open_form" data-id="'+row.dm_id+'">수정</a>';
}

$(document).ready(function(){
	$('#dg_data').datagrid({
        emptyMsg:'데이터가 없습니다.',
	 	onLoadError: function(request, status, error) {
	 		if (request.status == "303") {
				location.replace("/adm/login.do");
			} else {
				$.messager.alert("error", request.responseJSON.notice, "warning");
			}
	 	}
    });

    $("#fnSave").off().on('click', function () {
    	 window.open("/adm/searchword_form.do","searchword_new",option);
    });

	$("#fnRemove").off().on('click', function () {
        fnRemove();
	});
        
    $("#search_btn").off().on('click', function () {
        doSearch();
    });

    $("#stx").keypress(function(e){
        if(e.keyCode === 13){
            e.preventDefault();
            doSearch();
        }
    });

    var pager = $('#dg_data').datagrid('getPager');
    pager.pagination ({
        showPageList: true,
        layout:['info','sep','first','prev','links','next','last','list'],
        displayMsg : "검색 <strong>{to}</strong> 개 / 전체 <strong>{total}</strong> 개"
    });

    $(document).on('click', ".open_form", function () {
        var dm_id = $(this).data("id");
        window.open('/adm/searchword_form.do?dm_id='+dm_id,"searchword_form",option);
    });

});
</script>
<div class="easyui-layout" fit="true">
    <div data-options="region:'north', border:false">
        <div class="title">
            <h1>검색어 기록</h1>
			<div class="btnWrap">
				<button id="fnSave" class="bt01">신규생성</button>
			</div>
        </div>
        <div class="Srchbox">
            <div>
				<dl>
					<dt><strong>도메인명</strong></dt>
					<dd>
						<select id="search_domain" name="search_domain" class="easyui-combobox" panelHeight="auto"
            				data-options="url: '/adm/select_domain_id.do?search=1',
                            method: 'get',
                            valueField: 'dm_id',
                            textField: 'dm_domain_nm',
                            editable : false" ></select>
					</dd>
				</dl>
                <dl>
                    <dt>통합검색</dt>
                    <dd>
                        <select name="search_type" id="search_type">
                            <option value="">통합검색</option>
                            <option value="dm_word">검색어</option>
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

        <table id="dg_data" class="easyui-datagrid" data-options="pagePosition:'top',rownumbers:true,pagination:true, url:'/adm/get_search_word_log.do',method:'post', singleSelect:true,fitColumns:true,striped:false,selectOnCheck:false,checkOnSelect:false" border="false" pageList="[10,20,30,50,70,100]" pageSize="50" fit="true">
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
                <th data-options="field:'dm_domain_text',width:150,align:'center',fixed:true">도메인</th>
                <th data-options="field:'dm_word',align:'center',width:150,fixed:true">검색어</th>
                <th data-options="field:'dm_count',width:120,align:'center',fixed:true">검색횟수</th>
                <th data-options="field:'dm_sort',width:120,align:'center',fixed:true">추천점수</th>
                <th data-options="field:'dm_create_dt',width:100,align:'center'">등록일</th>
                <th data-options="field:'dm_modify_dt',width:100,align:'center'">최근검색일</th>
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