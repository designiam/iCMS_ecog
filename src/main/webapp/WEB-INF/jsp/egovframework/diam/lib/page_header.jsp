<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>CMS</title>
<meta http-equiv="Content-Type" charset="UTF-8">
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/jquery/jquery-1.4.3.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/jquery/jquery-1.10.2.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/easyui/jquery.easyui.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/easyui/jquery-easyui-texteditor/jquery.texteditor.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/colorpicker/colorpicker.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/tui.chart/dist/tui-chart-all.min.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/common.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/validator.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/diam/se2/js/HuskyEZCreator.js' />"></script>

<link type="text/css" rel="stylesheet" href="<c:url value='/js/egovframework/diam/easyui/themes/bootstrap/easyui.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/js/egovframework/diam/easyui/themes/icon.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/js/egovframework/diam/easyui/jquery-easyui-texteditor/texteditor.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/js/egovframework/diam/colorpicker/colorpicker.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/js/egovframework/diam/tui.chart/dist/tui-chart.min.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/page.css' />">
<script>
    //var lib_url = '';
    document.onkeydown = trapRefresh;
    function trapRefresh() {
        if (event.keyCode == 116)
        {
            event.keyCode = 0;
            event.cancelBubble = true;
            event.returnValue = false;
            document.location.reload();
        }
    }
    
    $(function(){
     	$(".easyui-combobox").combobox({
    		onLoadError: function(response){
    			$.messager.alert("경고", response.responseText, "warning");
            }
    	});
    });
</script>
</head>
<body>