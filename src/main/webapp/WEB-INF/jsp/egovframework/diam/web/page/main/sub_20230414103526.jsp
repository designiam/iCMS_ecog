<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- top.jsp의 타이틀러는 숨김 처리됨 -->
<div class="wide_con content-titler">
	<h2>ECO-G</h2>
</div>

<h3 class="content-leader">환경 소식지 소개</h3>


<!-- 환경 소식지 소개 -->
<div class="newsletter-container">
	<div class="txt">
		<div class="logo"><img src="<c:out value='${CONFIG_INFO.dm_top_logo}'/>" alt="<c:out value='${CONFIG_INFO.dm_site_name}'/>" onerror="this.src='<c:out value='${layout_path}'/>/images/logo.png'"/></div>
		<p>"함께 green 광주"는 광주환경공단이 계절마다 자연의 생태적 아름다움을 나누고 친환경적인 삶을 통한 환경사랑을 함께 실천하기 위해 발행하는 환경소식지입니다.</p>
		<a class="a-exlink-02 mt80" href="https://www.eco-g.or.kr/board.es?mid=a10305030100&bid=0031" target="_blank">
			<p>함께 green 광주 <b>지난호 바로가기</b></p>
			<svg xmlns="http://www.w3.org/2000/svg" width="17" height="17" viewBox="0 0 23.106 23.106">
				<path class="svg-color" d="M2.1,22.106A2.114,2.114,0,0,1,0,19.983V1.874H10.209V4.521H2.625V18.673a.782.782,0,0,0,.778.785H17.432V11.812h2.625V22.106ZM12.152,7.962l5.534-5.349L12.954,2.6V0h9.152V9.234h-2.58l-.009-4.774L13.982,9.808Z" transform="translate(0.5 0.5)" stroke-width="1"></path>
			</svg>
		</a>
	</div>
	<div class="img"></div>
</div>